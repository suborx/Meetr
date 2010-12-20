class Meetup < ActiveRecord::Base

  belongs_to :creator, :class_name => "User", :foreign_key => :user_id
  has_many :meetup_users
  has_many :users, :through => :meetup_users, :order => "created_at DESC"
  alias attendees users
  has_many :presentations
  has_many :timelines

  validates :name, :presence => true, :length => { :minimum => 4 }, :uniqueness => true
  validates :location, :presence => true
  validates :happening_at, :date => { :after => Time.now, :before => Time.now + 3.months }

  after_create :add_creator_to_attendees
  after_update :add_update_timeline

  default_scope order("created_at desc")

  def add_attendee(user)
    return false if users.include?(user) 
    self.attendees << user
    user.timelines.create(:meetup_id => id, :message => "is attending #{name}")
  end

  def attendee(user)
    meetup_users.where(:user_id => user.id).first
  end

  def update_attendee(user, attending = true)
    mu = attendee(user)
    mu.update_attributes!(:is_attending => attending)
    message = attending ? "is will now attend #{name}" : "will not attend #{name}"
    user.timelines.create(:meetup_id => id, :message => message)
  end

  def user_attends?(user)
    mu = attendee(user)
    true if mu && mu.is_attending
  end

  def num_of_attendees
    meetup_users.count(:conditions => { :is_attending => true })
  end

  private

  def add_creator_to_attendees
    add_attendee(creator)
  end

  def add_update_timeline
    self.creator.timelines << Timeline.new(:meetup_id => id, :message => "just changed details about #{name}")
  end

end
