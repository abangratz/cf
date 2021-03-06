class Article

  include DataMapper::Resource

  before :save, :sluggize
  before :save, :convert_body

  property :id, Serial

  property :title, String, :required => true, :unique => true
  property :body, Text
  property :body_html, Text
  property :conversion, String
  property :slug, Slug
  property :created_at, DateTime
  property :updated_at, DateTime

  validates_length_of :title, :minimum => 5

  belongs_to :admin

  def to_param
    self.slug
  end

  def sluggize
    self.slug = self.title
  end

  def convert_body
    self.body_html = body.send(self.conversion.to_sym)
  end

end
