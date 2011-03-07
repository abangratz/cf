class Character

  ALT_RANK_ID = 8
  ALT_OFFICER_RANK_ID = 4
  ALT_RANK_IDS = [4,8]
  include DataMapper::Resource

  property :name, String, :key => true, :length => 0..150
  property :level, Integer
  property :calling, String
  property :joined, DateTime
  property :lastlogouttime, DateTime
  property :personalnote, Text
  property :officernote, Text
  property :guildxp, Integer

  belongs_to :profile, :required => false
  belongs_to :rank
  belongs_to :main, self, :required => false
  has n, :alts, self, :child_key => [:main_name]

end
