class Sound < ActiveRecord::Base
  mount_uploader :file, SoundUploader
end
