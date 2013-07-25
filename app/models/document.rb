class Document < ActiveRecord::Base
  has_attached_file :doc,
    :path => ":rails_root/uploads/:file_type/:basename.:extension"
  
  validates_presence_of :file_type
  validates_attachment_presence :doc  
  validates_attachment_content_type :doc, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'application/pdf', 'application/zip']
end
