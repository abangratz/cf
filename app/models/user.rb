class User

  include DataMapper::Resource
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable


  property :id, Serial

  property :nickname, String, :required => true, :unique => true

  belongs_to :role
  has n, :topics, :child_key => [ :author_id ]
  has n, :replies, :child_key => [ :author_id ]
  has 1, :profile

  before :valid? do 
    self.role = Role.first(:name => "Guest") if self.role.nil?
    self.profile = Profile.create if self.profile.nil?
  end

  def can_read(forum)
    ForumRole.first(:forum_id => forum.id, :role_id => self.role.id).read
  end

  def can_write(forum)
    ForumRole.first(:forum_id => forum.id, :role_id => self.role.id).read
  end

  def can_moderate(forum)
    ForumRole.first(:forum_id => forum.id, :role_id => self.role.id).read
  end

  def forum_groups
    groups = ForumGroup.all
    groups.map do |group|
      forums = group.forums.select { |forum| self.can_read(forum) }
      forums.count > 0 ? group : nil
    end.compact
  end

end
