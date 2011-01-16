class Forum

  include DataMapper::Resource

  property :id, Serial

  property :name, String

  belongs_to :forum_group

  has n, :forum_roles
  has n, :topics, :order => [:created_at.desc]
  has n, :roles, :through => :permissions

  is :list, :scope => :forum_group_id

end
