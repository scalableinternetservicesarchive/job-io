CREATE TRIGGER refresh_company_to_user_view
AFTER INSERT OR UPDATE OR DELETE ON companies_users
FOR EACH STATEMENT
EXECUTE PROCEDURE refresh_company_to_user_view();