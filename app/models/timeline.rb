class Timeline < ActiveRecord::Base
  belongs_to :user
  belongs_to :meetup

  validates :message, :presence => true, :length => { :minimum => 2 }

  default_scope order("created_at DESC")
end
