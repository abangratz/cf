class Topic

  include DataMapper::Resource

  property :id, Serial

  property :title, String
  property :body, Text
  property :body_html, Text
  property :locked, Boolean, :default => false
  property :sticky, Boolean, :default => false
  property :last_reply_at, DateTime
  property :created_at, DateTime
  property :updated_at, DateTime
  property :deleted_at, ParanoidDateTime

  belongs_to :forum
  belongs_to :author, :model => User
  has n, :replies
  has n, :marked_topics

  validates_length_of :body, :minimum => 10
  validates_length_of :title, :minimum => 3

  before :valid? do
    if self.body
      self.body.strip!
      self.body_html = self.body.bbcode_to_html
    end
    if self.last_reply_at.nil?
      self.last_reply_at = Time.now
    end
  end

  after :save do
    self.forum.last_activity_at = self.last_reply_at
    self.forum.save
  end

end
