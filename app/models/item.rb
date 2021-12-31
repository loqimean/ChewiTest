class Item < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader

  belongs_to :folder

  validates_presence_of :attachment
  validates_uniqueness_of :file_name, scope: :folder_id

  before_create :set_file_name

  after_create { broadcast_append_to :items }
  after_update { broadcast_replace_to :items }
  after_destroy { broadcast_remove_to :items }

  private

  def set_file_name
    self.file_name = attachment.identifier
  end
end
