CREATE OR REPLACE FUNCTION refresh_user_to_company_view() RETURNS trigger AS $function$
BEGIN
  REFRESH MATERIALIZED VIEW user_to_companies;
  RETURN NULL;
END;
$function$ LANGUAGE plpgsql;