class ChangeProjectStatusToWorkflowState < ActiveRecord::Migration
  def change
    rename_column :projects, :status, :workflow_state
  end
end
