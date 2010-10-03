class Profile < ActiveRecord::Base
  belongs_to :account
  validates_presence_of :account
  s3 = Images::S3.new.configuration
  has_attached_file :avatar, s3.merge!(:styles => { :thumb => "148x128#", :medium => "320x320>", :original => "400x400>" })
end
