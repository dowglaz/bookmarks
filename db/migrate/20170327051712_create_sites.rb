class CreateSites < ActiveRecord::Migration[5.0]
  def change
    create_table :sites do |t|
      t.string :top_level_url

      t.timestamps
    end
  end
end
