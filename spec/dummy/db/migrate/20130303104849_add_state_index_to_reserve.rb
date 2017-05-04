class AddStateIndexToReserve < ActiveRecord::Migration[5.0]
  def change
    add_index :reserves, :state
  end
end
