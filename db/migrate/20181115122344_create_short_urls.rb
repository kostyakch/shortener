class CreateShortUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :short_urls do |t|
      t.string :uid, null: false
      t.string :original_url, null: false
      t.boolean :permanent, default: true, null: false, index: true

      t.timestamps
    end

    add_index :short_urls, :uid, unique: true
    add_index :short_urls, :original_url, unique: true
  end
end
