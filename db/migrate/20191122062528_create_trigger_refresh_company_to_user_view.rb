class CreateTriggerRefreshCompanyToUserView < ActiveRecord::Migration[5.0]
  def change
    create_trigger :refresh_company_to_user_view, on: :companies_users
  end
end
