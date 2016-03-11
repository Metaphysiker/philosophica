class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  acts_as_taggable
  has_many :blogs, dependent: :destroy
  has_many :blogposts
  has_many :events
  has_many :date_events
end
