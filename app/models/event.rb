class Event < ActiveRecord::Base
  belongs_to :status
  has_many :comments, dependent: :destroy
  
  validates :title, :content, :event_date, :resolved, :status, :presence => true
  
  #We don't want to be adding events with a non-existent status
  before_create :check_status_exists
  
  private
  
  #Check the status we are passed is present in the statuses table if so, all is good,
  #if not all is bad and let them know
  def check_event_exists
    if Event.exists?(status)
      return
    else
      errors.add(:status, "does not exist")
      return false
    end
  end
  
end
