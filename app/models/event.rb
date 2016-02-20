class Event < ActiveRecord::Base
  acts_as_taggable
  has_many :date_events
end
