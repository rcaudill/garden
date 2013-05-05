class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.integer :reading
      t.datetime :time_stamp

      t.timestamps
    end
  end
end
