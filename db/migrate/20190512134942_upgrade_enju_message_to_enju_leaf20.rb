class UpgradeEnjuMessageToEnjuLeaf20 < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up {
        change_table :message_request_transitions do |t|
          t.change :message_request_id, :bigint
        end

        change_table :message_requests do |t|
          t.change :message_template_id, :bigint
          t.change :receiver_id, :bigint
          t.change :sender_id, :bigint
        end

        change_table :message_transitions do |t|
          t.change :message_id, :bigint
        end

        change_table :messages do |t|
          t.change :message_request_id, :bigint
          t.change :parent_id, :bigint
          t.change :receiver_id, :bigint
          t.change :sender_id, :bigint
        end
      }

      dir.down {
        change_table :message_request_transitions do |t|
          t.change :message_request_id, :integer
        end

        change_table :message_requests do |t|
          t.change :message_template_id, :integer
          t.change :receiver_id, :integer
          t.change :sender_id, :integer
        end

        change_table :message_transitions do |t|
          t.change :message_id, :integer
        end

        change_table :messages do |t|
          t.change :message_request_id, :integer
          t.change :parent_id, :integer
          t.change :receiver_id, :integer
          t.change :sender_id, :integer
        end

        remove_index :message_requests, :message_template_id
        remove_index :message_requests, :receiver_id
        remove_index :message_requests, :sender_id

        remove_foreign_key :messages, "messages"
      }
    end
  end
end
