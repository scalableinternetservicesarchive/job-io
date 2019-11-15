class AddSummaryToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :summary, :string
  end
end
