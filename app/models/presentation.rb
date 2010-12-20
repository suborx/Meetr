class Presentation < ActiveRecord::Base
  belongs_to :user
  belongs_to :meetup
  has_many :votes

  validates :name, :presence => true, :length => { :minimum => 4 }
  validates :meetup_id, :presence => true
  validates_exclusion_of :duration, :in => %w(600 1200 2400), :message => "Presentation duration must by 10,20 or 40 minutes."

  after_create :add_timeline_entry
  default_scope order("created_at DESC")

  def give_vote!(user)
    votes << user.votes.new
    user.timelines << Timeline.new(:meetup_id => meetup_id, :message => "just voted for #{name}")
  end

  def to_html
    Maruku.new(description).to_html
  end

  private

  def add_timeline_entry
    user.timelines.create(:meetup_id => meetup_id, :message => "just submitted a new presentation #{name}")
  end

end
