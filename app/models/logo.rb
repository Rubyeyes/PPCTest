class Logo < ActiveRecord::Base
	mount_uploader :image, ImageUploader
end
