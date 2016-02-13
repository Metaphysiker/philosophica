class AddBlogIdToBlogposts < ActiveRecord::Migration
  def change
    add_column :blogposts, :blog_id, :integer
  end
end
