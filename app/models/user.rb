class User < ActiveRecord::Base

  has_many :user_tokens
  has_one :account

  has_many :timelines
  has_many :meetups
  has_many :presentations
  has_many :votes
  has_many :meetup_users
  has_many :attendances, :source => :meetup, :through => :meetup_users

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  after_create :create_user_account

  def create_user_account
    build_account(:name => email.split('@').first).save
  end

  def create_account!(name, url)
    account.update_attributes(:name => name, :url => url)
  end

  #def to_s
    #self.account.name
  #end

end
