class Role

  include DataMapper::Resource

  property :id, Serial

  property :name, String

  has n, :users, :through => Resource

end
