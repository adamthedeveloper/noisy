class Profile < ActiveRecord::Base
  belongs_to :account
  validates_presence_of :account

  mount_uploader :avatar, AvatarUploader, :as => :avatar

  wepayable :wepay_auth_code

  def full_name
    "#{first_name} #{last_name}"
  end

  def location
    "#{city}, #{state}"
  end

  def avatar_url(type)
    return avatar.send(type).url if avatar.present?
    '/images/logo.png'
  end
end
