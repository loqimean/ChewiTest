class Item < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader

  after_create { broadcast_append_to :items }
  after_update { broadcast_replace_to :items }
  after_destroy { broadcast_remove_to :items }

  before_create :set_file_name

  private

  def set_file_name
    self.file_name = attachment.identifier
  end
end
