class AddDataToEntries < ActiveRecord::Migration[5.0]
  def change
    add_column :entries, :total, :integer, default: 5
    add_column :entries, :votes, :integer, default: 1
  end
end
