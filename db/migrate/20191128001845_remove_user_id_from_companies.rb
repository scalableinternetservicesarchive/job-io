class RemoveUserIdFromCompanies < ActiveRecord::Migration[6.0]
  def change
    remove_column :companies, :user_id
  end
end
