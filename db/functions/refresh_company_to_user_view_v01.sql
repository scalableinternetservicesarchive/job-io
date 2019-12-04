CREATE OR REPLACE FUNCTION refresh_company_to_user_view() RETURNS trigger AS $function$
BEGIN
  REFRESH MATERIALIZED VIEW company_to_users;
  RETURN NULL;
END;
$function$ LANGUAGE plpgsql;