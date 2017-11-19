class AddProfileIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :profile, foreign_key: true, type: :uuid
  end
end
