class CreateUserToCompanies < ActiveRecord::Migration[6.0]
  def change
    create_view :user_to_companies, materialized: true
    add_index :user_to_companies, :user_id
  end
end
