class CreateTimeTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :time_tracks do |t|
      t.belongs_to :teacher
      t.datetime :clock_in
      t.datetime :clock_out

      t.timestamps
    end
  end
end
