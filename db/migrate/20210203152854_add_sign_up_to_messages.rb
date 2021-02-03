class AddSignUpToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :sign_up, :boolean
  end
end
