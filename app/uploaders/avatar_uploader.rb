# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  require 'carrierwave/processing/rmagick'
  
  # Include RMagick or ImageScience support:
  include CarrierWave::MiniMagick
  # include CarrierWave::ImageScience

  # Choose what kind of storage to use for this uploader:
  #storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  #process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  #(:styles => { :tiny => "66x49#", :thumb => "202x148#", :medium => "320x320>", :original => "400x400>" })
  version :tiny do
     process :resize_to_fill => [66, 49]
  end

  version :thumb do
    process :resize_to_fill => [202, 148]
  end

  version :medium do
    process :resize_to_fit => [320, 320]
  end

  version :original do
    process :resize_to_fit => [400, 400]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
