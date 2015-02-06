class DropTasksTables < ActiveRecord::Migration
  def change
    drop_table :tasks_tables
  end
end
