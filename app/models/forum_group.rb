class ForumGroup

  include DataMapper::Resource

  property :id, Serial

  property :name, String

  has n, :forums, :order => [ :position.asc ]
  
  is :list

end
