class RemoveCompanyIdFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :company_id
  end
end
