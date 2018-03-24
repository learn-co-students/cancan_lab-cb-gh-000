class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :content
      t.references :user, index: true, foreign_key: true, limit: 8

      t.timestamps null: false
    end
  end
end
