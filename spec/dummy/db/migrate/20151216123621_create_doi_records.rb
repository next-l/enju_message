class CreateDoiRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :doi_records do |t|
      t.string :body, index: true, null: false
      t.string :registration_agency
      t.references :manifestation, index: true, null: false
      t.string :source

      t.timestamps
    end
  end
end
