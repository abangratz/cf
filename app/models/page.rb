class Page

  include DataMapper::Resource

  before :save, :sluggize

  property :id, Serial

  property :title, String
  property :body, Text
  property :body_html, Text
  property :slug, Slug
  property :created_at, DateTime
  property :updated_at, DateTime
  property :in_menu, Boolean, :required => true, :default => false

  is :list

  validates_length_of :title, :minimum => 3

  belongs_to :admin

  def to_param
    self.slug
  end

  def sluggize
    self.slug = self.title
  end

  before :valid? do
    if self.body
      self.body.strip!
      self.body_html = self.body.markdown
    end
  end

end
