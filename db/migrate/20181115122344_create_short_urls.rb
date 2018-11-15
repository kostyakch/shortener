class CreateShortUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :short_urls do |t|
      t.string :uid, null: false
      t.string :url, null: false
      t.boolean :permanent, default: true, null: false, index: true

      t.timestamps
    end

    add_index :short_urls, :uid, unique: true
    add_index :short_urls, :url, unique: true
  end
end
