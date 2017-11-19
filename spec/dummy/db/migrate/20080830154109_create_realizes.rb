class CreateRealizes < ActiveRecord::Migration[5.1]
  def change
    create_table :realizes do |t|
      t.references :agent, null: false, type: :uuid
      t.references :expression, null: false, type: :uuid
      t.integer :position

      t.timestamps
    end
  end
end
