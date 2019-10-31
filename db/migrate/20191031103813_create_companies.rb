class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.datetime :createdAt
      t.datetime :modifiedAt
      t.datetime :deletedAt

      t.timestamps
    end
  end
end
