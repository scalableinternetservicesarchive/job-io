class CreateFunctionRefreshUserToCompanyView < ActiveRecord::Migration[5.0]
  def change
    create_function :refresh_user_to_company_view
  end
end
