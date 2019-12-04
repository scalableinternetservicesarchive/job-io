CREATE TRIGGER refresh_user_to_company_view
AFTER INSERT OR UPDATE OR DELETE ON companies_users
FOR EACH STATEMENT
EXECUTE PROCEDURE refresh_user_to_company_view();