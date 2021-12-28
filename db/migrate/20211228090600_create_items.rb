class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :file_name
      t.string :attachment

      t.timestamps
    end
  end
end
