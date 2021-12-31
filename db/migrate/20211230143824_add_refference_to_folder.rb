class AddRefferenceToFolder < ActiveRecord::Migration[6.1]
  def change
    add_reference :items, :folder, null: false, foreign_key: true
  end
end
