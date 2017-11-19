class AddStateIndexToReserve < ActiveRecord::Migration[5.1]
  def change
    add_index :reserves, :state
  end
end
