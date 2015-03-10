class UpdateColumnTasksProjectId < ActiveRecord::Migration
  def change
    change_column :tasks, :project_id, 'integer USING CAST(project_id AS integer)'
  end
end
