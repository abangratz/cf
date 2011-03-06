class Rank

  include DataMapper::Resource

  property :id, Serial

  property :id, Serial
  property :name, String
  
  has n, :characters

end
