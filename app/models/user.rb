class User

  include DataMapper::Resource
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable


  property :id, Serial

  property :nickname, String, :required => true, :unique => true

  has n, :roles, :through => Resource
  has n, :topics, :child_key => [ :author_id ]
  has n, :replies, :child_key => [ :author_id ]

end
