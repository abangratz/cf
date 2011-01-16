class Role

  include DataMapper::Resource

  property :id, Serial

  property :name, String

  has n, :forum_roles
  has n, :users, :through => Resource
  has n, :forums, :through => :permissions

end
