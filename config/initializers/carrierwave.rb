CarrierWave.configure do |config|
  config.ignore_integrity_errors = false
  config.ignore_processing_errors = false
  config.fog_credentials = {
     provider:              'AWS',                        # required
     aws_access_key_id:     Rails.application.credentials.aws[:access_key_id],                        # required unless using use_iam_profile
     aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],                        # required unless using use_iam_profile
     use_iam_profile:       false,                         # optional, defaults to false
     region:                'us-west-2',                  # optional, defaults to 'us-east-1'
     # host:                  's3.example.com',             # optional, defaults to nil
     # endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
   }
   config.fog_directory  = 'job-io-resumes'                                      # required
   config.fog_public     = false                                                 # optional, defaults to true
   # config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {} config.ignore_download_errors = false
end

