class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :startDate
      t.string :endDate
      t.string :employer
      t.text :description
      t.string :location
      t.string :webpage

      t.timestamps
    end
  end
end
