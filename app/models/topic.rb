class Topic

  include DataMapper::Resource

  property :id, Serial

  property :title, String
  property :body, Text
  property :body_html, Text
  property :locked, Boolean, :default => false
  property :sticky, Boolean, :default => false
  property :created_at, DateTime
  property :updated_at, DateTime
  property :deleted_at, ParanoidDateTime

  belongs_to :forum
  belongs_to :author, :model => User
  has n, :replies

  validates_length_of :body, :minimum => 10
  validates_length_of :title, :minimum => 3

  before :valid? do
    if self.body
      self.body.strip!
      self.body_html = self.body.bbcode_to_html
    end
  end

end
