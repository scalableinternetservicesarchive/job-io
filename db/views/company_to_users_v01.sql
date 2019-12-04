SELECT companies_users.company_id, users.*
FROM companies_users
INNER JOIN users ON companies_users.user_id = users.id;