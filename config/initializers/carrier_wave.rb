if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Amazon S3用の設定
      provider: "AWS",
      region: ENV["S3_REGION"],
      aws_access_key_id: ENV["S3_ACCESS_KEY"],
      aws_secret_access_key: ENV["S3_SECRET_KEY"]
    }
    config.fog_directory     =  ENV["S3_BUCKET"]
    config.fog_public     = true
  end
end
