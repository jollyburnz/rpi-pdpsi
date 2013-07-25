class CreateBrothers < ActiveRecord::Migration
  def self.up
    create_table :brothers do |t|
      t.string :name
      t.string :pledge_name
      t.string :pledge_class
      t.string :crossing
      t.string :ethnicity
      t.string :hometown
      t.boolean :alumnus

      t.timestamps
    end
  end

  def self.down
    drop_table :brothers
  end
end
