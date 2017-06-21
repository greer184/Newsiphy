class AddDataToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :voting_power, :float, default: 5.0
    add_column :users, :consistency, :float, default: 0.0
  end
end
