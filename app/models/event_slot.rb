class EventSlot

  include DataMapper::Resource

  property :id, Serial
  
  belongs_to :calendar_event
  belongs_to :character

  belongs_to :first_slot_role, 'SlotRole'
  belongs_to :second_slot_role, 'SlotRole'
  belongs_to :third_slot_role, 'SlotRole'


end
