class Forum

  include DataMapper::Resource

  property :id, Serial

  property :name, String
  property :last_activity_at, DateTime
  property :deleted_at, ParanoidDateTime

  belongs_to :forum_group

  has n, :forum_roles
  has n, :topics, :order => [:sticky.desc, :last_reply_at.desc]
  has n, :roles, :through => Resource

  is :list, :scope => :forum_group_id

  after :save, :create_roles

  def create_roles
    roles = Role.all
    roles.each do |role|
      self.roles << role
    end
  end

end
