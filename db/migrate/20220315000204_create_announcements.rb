class CreateAnnouncements < ActiveRecord::Migration[6.1]
  def change
    create_table :announcements do |t|
      t.string :name
      t.integer :creator_id
      t.datetime :time
      t.string :desc

      t.timestamps
    end
  end
end