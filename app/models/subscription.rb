class Subscription

  ROLE_NAMES = %w{Damage Healer Tank Support}
  COMMITMENTS = %w{Sure Tentative Maybe No Can't}

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

  def toggle_confirmation
    self.confirmed = !self.confirmed
    save!
  end

end
