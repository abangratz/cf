class Role

  include DataMapper::Resource

  property :id, Serial

  property :name, String

  has n, :forum_roles
  has n, :users
  has n, :forums, :through => Resource

end
