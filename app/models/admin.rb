class Admin

  include DataMapper::Resource
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, 
         :recoverable, :rememberable


  property :id, Serial
  property :name, String, :length => 50
  has n, :articles


end
