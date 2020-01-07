class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :location
      t.datetime :start_time
      t.datetime :end_time
      t.string :sign_in_id

      t.timestamps
    end
  end
end
