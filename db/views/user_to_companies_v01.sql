SELECT companies_users.user_id, companies.name
FROM  companies_users
INNER JOIN companies ON companies_users.company_id = companies.id;