class AdduserImageTOusers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :user_image, :text
  end
end
