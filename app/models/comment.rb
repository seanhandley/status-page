class Comment < ActiveRecord::Base
  belongs_to :event
  validates :event_id, :comment, :added_by, :presence => true
  
  #We don't want to be adding comments for events that don't exist, that would be silly
  before_create :check_event_exists
  
  private
  
  #Check the event_id we are passed is present in the events table if so, all is good,
  #if not all is bad and let them know
  def check_event_exists
    if Event.exists?(event_id)
      return
    else
      errors.add(:event_id, "does not exist")
      return false
    end
  end
end
