class CalendarEvent

  include DataMapper::Resource

  property :id, Serial

  property :title, String
  property :location, String
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
  has n, :event_slots

  def allDay
    false
  end

  def to_json(options)
    options = {:methods => [:allDay]}.merge(options)
    super(options)
  end

end
