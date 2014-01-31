class Event < ActiveRecord::Base
  belongs_to :status
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments, :allow_destroy => true, :reject_if => lambda { |a| a[:comment].blank? }
  
  validates :title, :content, :event_date, :status_id, :presence => true
  
  #We don't want to be adding events with a non-existent status
  before_create :check_status_exists
  
  private
  
  #Check the status we are passed is present in the statuses table if so, all is good,
  #if not all is bad and let them know
  def check_status_exists
    if Status.exists?(status_id)
      return
    else
      errors.add(:status, "does not exist")
      return false
    end
  end
  
end
