class AddCompanyidFkToAdmin < ActiveRecord::Migration[6.0]
  def change
    add_reference :admins, :company, foreign_key: true
  end
end
