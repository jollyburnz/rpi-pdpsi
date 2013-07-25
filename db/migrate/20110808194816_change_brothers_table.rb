class ChangeBrothersTable < ActiveRecord::Migration
  def self.up
    add_column :brothers, :bio, :text
  end

  def self.down
    drop_column :brothers, :bio
  end
end
