class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :attachment
      t.references :folder, foreign_key: true

      t.timestamps
    end
  end
end
