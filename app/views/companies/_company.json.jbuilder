json.extract! company, :id, :name, :createdAt, :modifiedAt, :deletedAt, :created_at, :updated_at, :qr_code, :summary
json.url company_url(company, format: :json)
