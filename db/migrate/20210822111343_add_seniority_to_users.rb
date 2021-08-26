class AddSeniorityToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :seniority, :string
  end
end
