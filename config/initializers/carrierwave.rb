CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',       # required
      :aws_access_key_id      => 'AKIAI2PR64DTRRE3VMYQ',       # required
      :aws_secret_access_key  => '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',       # required
      :region                 => 'us-west-2'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'feedituploads'                     # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end