class Instruction < ActiveRecord::Base
  belongs_to :project


	mount_uploader :instruction, InstructionUploader
end
