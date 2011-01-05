class Reply 

  include DataMapper::Resource

  property :id, Serial

  property :title, String
  property :body, Text
  property :body_html, Text
  property :created_at, DateTime
  property :updated_at, DateTime

  belongs_to :topic 
  belongs_to :author, :model => User
  validates_length_of :body, :min => 10

  before :valid? do
    if self.body
      self.body.strip!
      self.body_html = self.body.bbcode_to_html
    end
  end
end
