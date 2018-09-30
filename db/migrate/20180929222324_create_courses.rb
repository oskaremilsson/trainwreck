class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :code
      t.string :title
      t.float :credits
      t.integer :state
      t.string :school
      t.string :courseplan
      t.string :description

      t.timestamps
    end
  end
end
