class DeleteDatetimeFieldsFromCompanies < ActiveRecord::Migration[6.0]
  def change
    remove_column :companies, :createdAt
    remove_column :companies, :modifiedAt
    remove_column :companies, :deletedAt
  end
end
