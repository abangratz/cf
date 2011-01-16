class Profile

  include DataMapper::Resource
  include Paperclip::Resource

  before :save, :convert_signature

  property :id, Serial

  property :signature, Text
  property :signature_html, Text

  property :created_at, DateTime
  property :updated_at, DateTime

  belongs_to :user

  has_attached_file :avatar, :styles => {:original => '65x65>'}, :default_url => '/images/avatar/cf.png'

  def convert_signature
    self.signature_html = self.signature.bbcode_to_html if self.signature
  end

end
