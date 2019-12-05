SELECT companies_users.company_id, users.id, users.email, users.encrypted_password,
      users.first_name, users.last_name, users.summary, users.resume_link, users.created_at, users.updated_at, users.resume
FROM companies_users
INNER JOIN users ON companies_users.user_id = users.id;