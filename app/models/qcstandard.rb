class Qcstandard < ActiveRecord::Base
  belongs_to :project


	mount_uploader :file, QcstandardUploader
end
