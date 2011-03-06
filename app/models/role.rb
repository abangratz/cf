class Role

  include DataMapper::Resource

  property :id, Serial

  property :name, String
  property :member, Boolean, :default => false

  has n, :forum_roles
  has n, :users
  has n, :forums, :through => Resource

end
