class CreateFunctionRefreshCompanyToUserView < ActiveRecord::Migration[5.0]
  def change
    create_function :refresh_company_to_user_view
  end
end