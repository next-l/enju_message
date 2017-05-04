class AddExtentOfTextToManifestation < ActiveRecord::Migration[5.0]
  def change
    add_column :manifestations, :extent_of_text, :text
  end
end
