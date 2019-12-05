class Company < ApplicationRecord
    # validate uniqueness and presence when creating a company
    validates :name, presence: true, uniqueness: true
    has_and_belongs_to_many :users, touch: true

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

    def self.find_applicants_sql(sql_array, page)
        User.find_by_sql(sql_array).paginate(page: page, per_page: 5)
    end

end
