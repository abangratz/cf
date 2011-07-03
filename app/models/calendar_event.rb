class CalendarEvent

  include DataMapper::Resource

  property :id, Serial

  property :title, String, :required => true, :length => 10..50
  property :location, String, :required => true, :length => 5..50
  property :comment, Text
  property :start, DateTime
  property :end, DateTime
  property :public, Boolean
  property :max, Integer
  property :overcommit, Integer
  property :locked, Boolean

  property :created_at, DateTime
  property :updated_at, DateTime
  property :deleted_at, ParanoidDateTime

  belongs_to :user
  has n, :subscriptions

  validates_length_of :comment, :min => 15

  def start
    super.in_time_zone.to_datetime
  end

  def end
    super.in_time_zone.to_datetime
  end

  def allDay
    false
  end

  def to_json(options)
    options = {:methods => [:start, :end, :allDay]}.merge(options)
    super(options)
  end

end
