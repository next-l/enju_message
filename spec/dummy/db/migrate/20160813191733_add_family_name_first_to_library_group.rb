class AddFamilyNameFirstToLibraryGroup < ActiveRecord::Migration[4.2]
  def change
    add_column :library_groups, :family_name_first, :boolean, default: true
  end
end
