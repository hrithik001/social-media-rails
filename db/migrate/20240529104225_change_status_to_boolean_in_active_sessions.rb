class ChangeStatusToBooleanInActiveSessions < ActiveRecord::Migration[7.1]
  def up
    # First, add a new boolean column
    add_column :active_sessions, :status_temp, :boolean, default: false

    # Then, populate the new column with the correct data
    ActiveSession.reset_column_information
    ActiveSession.find_each do |session|
      session.update_columns(status_temp: session.status == 'true')
    end

    # Remove the old column
    remove_column :active_sessions, :status

    # Rename the new column to replace the old one
    rename_column :active_sessions, :status_temp, :status
  end

  def down
    # Revert the changes if needed
    add_column :active_sessions, :status_temp, :string

    ActiveSession.reset_column_information
    ActiveSession.find_each do |session|
      session.update_columns(status_temp: session.status ? 'true' : 'false')
    end

    remove_column :active_sessions, :status
    rename_column :active_sessions, :status_temp, :status
  end
end
