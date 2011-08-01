class CalendarEvent

  include DataMapper::Resource

  property :id, Serial

  property :title, String, :required => true#, :length => 10..50
  property :location, String, :required => true#, :length => 5..50
  property :comment, Text
  property :utc_start, ZonedTime, :required => true
  property :utc_end, ZonedTime, :required => true
  property :public, Boolean
  property :max, Integer
  property :overcommit, Integer
  property :locked, Boolean

  property :created_at, DateTime
  property :updated_at, DateTime
  property :deleted_at, ParanoidDateTime

  belongs_to :user
  has n, :subscriptions, :constraint => :destroy!

  #validates_length_of :comment, :min => 15

  def allDay
    false
  end

  def start=(time)
    self.utc_start = case time
                     when ::String
                       DateTime.parse(time).utc
                     else 
                       time.utc
                     end
  end

  def end=(time)
    self.utc_end = case time
                     when ::String
                       DateTime.parse(time).utc
                     else 
                       time.utc
                     end
  end

  def start
    self.utc_start.in_time_zone
  end

  def end
    self.utc_end.in_time_zone
  end

  def to_json(options)
    options = {:methods => [:start, :end, :allDay]}.merge(options)
    super(options)
  end

end
