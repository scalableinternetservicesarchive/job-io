class CreateTriggerRefreshUserToCompanyView < ActiveRecord::Migration[5.0]
  def change
    create_trigger :refresh_user_to_company_view, on: :companies_users
  end
end
