class Company < ApplicationRecord
    # validate uniqueness and presence when creating a company
    validates :name, presence: true, uniqueness: true

    def self.search(search)
        if search
            company = Company.find_by(name: search)
            if company
                self.where(id: company)
            else
                Company.all
            end
        else
            Company.all
        end  
    end

end