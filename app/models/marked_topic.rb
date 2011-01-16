class MarkedTopic
  include DataMapper::Resource

  property :last_read, DateTime
  
  belongs_to :topic, :key => true
  belongs_to :user, :key => true
  
end
