class CreateCompanyToUsers < ActiveRecord::Migration[6.0]
  def change
    create_view :company_to_users, materialized: true
    add_index :company_to_users, :company_id
  end
end
