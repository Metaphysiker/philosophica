class Blogpost < ActiveRecord::Base
  belongs_to :blog

  include PgSearch
  multisearchable :against => [:content]

end
