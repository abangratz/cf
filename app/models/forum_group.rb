class ForumGroup

  include DataMapper::Resource

  property :id, Serial

  property :name, String

  has n, :forums

end
