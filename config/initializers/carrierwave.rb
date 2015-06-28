CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',       # required
      :aws_access_key_id      => 'AKIAI4LR2XYQOYDZDY6Q',       # required
      :aws_secret_access_key  => '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',       # required
      :region                 => 'us-west-2'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'tutemate-production'                     # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end