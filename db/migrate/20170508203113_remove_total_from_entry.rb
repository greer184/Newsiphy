class RemoveTotalFromEntry < ActiveRecord::Migration[5.0]
  def change
    remove_column :entries, :total, :integer
  end
end
