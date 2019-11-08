class RemoveReferenceFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :company_id_id
  end
end
