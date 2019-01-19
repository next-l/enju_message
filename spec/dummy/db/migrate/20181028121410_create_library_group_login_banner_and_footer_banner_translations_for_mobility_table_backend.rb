class CreateLibraryGroupLoginBannerAndFooterBannerTranslationsForMobilityTableBackend < ActiveRecord::Migration[5.2]
  def change
    unless defined?(Globalize)
      create_table :library_group_translations do |t|

        # Translated attribute(s)
        t.text :login_banner
        t.text :footer_banner

        t.string  :locale, null: false
        t.references :library_group, null: false, foreign_key: true, index: false

        t.timestamps null: false
      end

      add_index :library_group_translations, :locale, name: :index_library_group_translations_on_locale
      add_index :library_group_translations, [:library_group_id, :locale], name: :index_library_group_translations_on_library_group_and_locale, unique: true
    end
  end
end
