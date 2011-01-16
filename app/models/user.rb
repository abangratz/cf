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
  has 1, :profile

  def can_read(forum)
    self.roles.each do |role|
      forum_role = ForumRole.first(:forum_id => forum.id, :role_id => role.id)
      return true if forum_role.read
    end
    false
  end

  def can_write(forum)
    self.roles.each do |role|
      forum_role = ForumRole.first(:forum_id => forum.id, :role_id => role.id)
      return true if forum_role.write
    end
    false
  end

  def forum_groups
    groups = ForumGroup.all
    groups.map do |group|
      forums = group.forums.select { |forum| self.can_read(forum) }
      forums.count > 0 ? group : nil
    end.compact
  end

end
