class ChangeStatusToSessionStatusInActiveSessions < ActiveRecord::Migration[7.1]
  def up
    # Add a new boolean column
    add_column :active_sessions, :session_status, :boolean, default: false

    # Populate the new column with the correct data
    ActiveSession.reset_column_information
    ActiveSession.find_each do |session|
      session.update_columns(session_status: session.status == 'true')
    end

    # Remove the old column
    remove_column :active_sessions, :status
  end

  def down
    # Add the old column back
    add_column :active_sessions, :status, :string

    # Populate the old column with the data from session_status
    ActiveSession.reset_column_information
    ActiveSession.find_each do |session|
      session.update_columns(status: session.session_status ? 'true' : 'false')
    end

    # Remove the new column
    remove_column :active_sessions, :session_status
  end
end