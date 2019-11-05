class AddQrcodeToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :qr_code, :string
  end
end
