class Subscription

  include DataMapper::Resource

  property :id, Serial

  property :primary_role, String
  property :secondary_role, String
  property :tertiary_role, String
  property :commitment, String
  property :confirmed, Boolean

  property :created_at, DateTime
  property :updated_at, DateTime
  
  belongs_to :calendar_event
  belongs_to :character

end
