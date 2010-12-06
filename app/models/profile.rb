class Profile < ActiveRecord::Base
  belongs_to :account
  validates_presence_of :account
  s3 = Images::S3.new.configuration
  has_attached_file :avatar, s3.merge!(:styles => { :tiny => "66x49#", :thumb => "202x148#", :medium => "320x320>", :original => "400x400>" })

  def full_name
    "#{first_name} #{last_name}"
  end

  def location
    "#{city}, #{state}"
  end
end
