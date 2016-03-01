CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',       # required
      :aws_access_key_id      => 'AKIAIMCHXT5CTFTIWOPA',       # required
      :aws_secret_access_key  => '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',       # required
      :region                 => 'ap-southeast-1'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'feedits3'                     # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
