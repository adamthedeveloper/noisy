CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider                         => 'Google',
    :google_storage_access_key_id     => 'GOOG4PS4FCH7H2BVJ4CK',
    :google_storage_secret_access_key => 'wEpSwFf8X3IXdfud8oorTGUOHhvXuJjVOZrCrIP+'
  }
  config.fog_directory = 'com-noisebytes-dev'
end