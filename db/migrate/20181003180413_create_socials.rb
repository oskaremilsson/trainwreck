class CreateSocials < ActiveRecord::Migration[5.2]
  def change
    create_table :socials do |t|
      t.string :site
      t.string :link

      t.timestamps
    end
  end
end
