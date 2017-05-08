class RemoveVotesFromEntry < ActiveRecord::Migration[5.0]
  def change
    remove_column :entries, :votes, :integer
  end
end
