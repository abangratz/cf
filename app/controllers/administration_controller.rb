class AdministrationController < ApplicationController
  before_filter :authenticate_admin!
  def index
  end
  def upload_guild_xml
    file = params[:xml]
    xml = Nokogiri::XML.parse file
    Rank.transaction do
      xml.xpath('.//Ranks/Rank').each do |ranknode|
        id = ranknode.xpath('.//Id').first.content.to_i+1
        rank = Rank.first(:id => id) || Rank.new
        rank.name = ranknode.xpath('.//Name').first.content
        rank.id = id
        rank.save!
      end
    end
    Character.transaction do
      alts = []
      existing_characters = Character.all
      new_characters = []
      xml.xpath('.//Members/Member').each do |membernode|
        rank = membernode.xpath('.//Rank').first.content.to_i + 1
        name = membernode.xpath('.//Name').first.content
        profile = Profile.first(:user => {:nickname.like => name})
        officernote = membernode.xpath('.//OfficerNotes').first.content
        main_name = officernote.scan(/\w+/).first
        attributes = {
          :name => name, 
          :rank => Rank.get(rank), 
          :level => membernode.xpath('.//Level').first.content,
          :calling => membernode.xpath('.//Calling').first.content,
          :joined => membernode.xpath('.//Joined').first.content,
          :lastlogouttime => membernode.xpath('.//LastLogOutTime').first.content,
          :personalnote => membernode.xpath('.//PersonalNotes').first.content,
          :officernote => officernote,
          :guildxp => membernode.xpath('.//GuildXPContribution').first.content,
          :main_name => main_name,
          :profile => profile
        }
        if Character::ALT_RANK_IDS.include?(rank.to_i)
          alts << attributes
        else
          character = Character.first(:name => name) || Character.create
          attributes.delete(:profile) if character.profile
          character.attributes = attributes
          character.save!
          new_characters << character
        end
      end
      alts.each do |attributes|
        character = Character.first(:name => attributes[:name] ) || Character.new
        attributes.delete(:profile) if character.profile
        character.attributes = attributes
        character.save!
        new_characters << character
      end
      deletable_characters = existing_characters - new_characters
      deletable_characters.map(&:destroy)
    end
    redirect_to '/administration', :notice => "Done"
  end
end
