class Company < ApplicationRecord
    # validate uniqueness and presence when creating a company
    validates :name, presence: true, uniqueness: true
end
