# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

%w(Officer Member Initiate Recruit Guest).each do |name|
  Role.first_or_create(:name => name)
end

testy = User.first_or_create({:email => 'test@twincode.net'}, {:password => 'testing', :password_confirmation => 'testing', :nickname => 'Testy'})

testy.role = Role.first(:name => 'Recruit')
testy.save
