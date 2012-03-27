class User

  include DataMapper::Resource
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable


  property :id, Serial

  property :nickname, String, :required => true, :unique => true
  property :ex_member, Boolean, :default => false
  property :calendar_admin, Boolean, :default => false

  belongs_to :role
  has n, :topics, :child_key => [ :author_id ]
  has n, :replies, :child_key => [ :author_id ]
  has 1, :profile
  has n, :marked_topics
  has n, :marked_forums

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
    groups = ForumGroup.all.reload
    groups.map do |group|
      forums = group.forums.reload.select { |forum| Rails.logger.debug "Checking forum #{forum.name}"; self.can_read(forum) }
      forums.count > 0 ? group : nil
    end.compact
  end

  def topic_unread?(topic)
    marked = self.marked_topics.first(:topic => topic)
    marked.nil? || topic.last_reply_at > marked.last_read
  end

  def forum_unread?(forum)
    marked = self.marked_forums.first(:forum => forum)
    marked.nil? || (forum.last_activity_at && forum.last_activity_at > marked.last_read_at)
  end

  def member?
    self.role.member?
  end

  def to_s
    "#{super}(#{id}): email='#{email}', nickname='#{nickname}'"
  end

end
