class Blog < ActiveRecord::Base
  has_many :blogposts, dependent: :destroy
  belongs_to :user
end
