class Character

  include DataMapper::Resource

  property :name, String, :key => true
  property :level, Integer
  property :calling, String
  property :joined, Timestamp
  property :lastlogouttime, Timestamp
  property :personalnote, String
  property :officernote, String
  property :guildxp, Integer

  belongs_to :profile
  belongs_to :rank
  has n, :alts, :through => Resource

end
