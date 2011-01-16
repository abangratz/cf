class MarkedForum
  include DataMapper::Resource

  property :last_read_at, DateTime

  belongs_to :user, :key => true
  belongs_to :forum, :key => true
end
