class ChangeImagesToJson < ActiveRecord::Migration[5.2]
  def change
    change_column :projects, :images, :json
  end
end
