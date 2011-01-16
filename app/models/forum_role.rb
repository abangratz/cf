class ForumRole
  include DataMapper::Resource
  
  belongs_to :role, :key => true
  belongs_to :forum, :key => true

  property :read, Boolean
  property :write, Boolean
  property :moderate, Boolean
end
