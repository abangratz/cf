# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

%w(Officer Member Initiate Recruit Guest).each do |name|
  Role.first_or_create(:name => name, :member => name != 'Guest')
end

testy = User.first_or_create({:email => 'test@twincode.net'}, {:password => 'testing', :password_confirmation => 'testing', :nickname => 'Testy'})

testy.role = Role.first(:name => 'Recruit')
testy.save

membery = User.first_or_create({:email => 'member@twincode.net'}, {:password => 'membering', :password_confirmation => 'membering', :nickname => 'Membery'})

membery.role = Role.first(:name => 'Member')
membery.save

admin = Admin.first_or_create({:email => 'admin@critical-failure.eu'}, {:name => "Admin", :password => 'testing', :password_confirmation => 'testing'})

public_group = ForumGroup.first_or_create({:name => "Public"})
forum = public_group.forums.first_or_create({:name => 'Say Hello'})
Role.all.each do |role|
  fr = ForumRole.first_or_create({:forum_id => forum.id, :role_id => role.id}, {:read => true, :write => true})
  fr.read = true
  fr.write = true
  fr.moderate = false
  fr.save
end
member_group = ForumGroup.first_or_create({:name => "Members"})
forum = member_group.forums.first_or_create({:name => "Off Topic"})
Role.all(:name.not => ["Recruit", "Guest"]).each do |role|
  fr = ForumRole.first_or_create({:forum_id => forum.id, :role_id => role.id}, {:read => true, :write => true})
  fr.read = true
  fr.write = true
  fr.moderate = false
  fr.save
end

Role.all(:name => ["Recruit", "Guest"]).each do |role|
  fr = ForumRole.first_or_create({:forum_id => forum.id, :role_id => role.id}, {:read => true, :write => true})
  fr.read = false
  fr.write = false
  fr.moderate = false
  fr.save
end
