class CreateAgentTypes < ActiveRecord::Migration
  def self.up
    create_table :agent_types do |t|
      t.string :name, :null => false
      t.text :display_name
      t.text :note
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :agent_types
  end
end
