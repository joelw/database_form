class FormFile < ActiveRecord::Base
  has_attachment :storage => :file_system, 
                     :max_size => 10.megabytes
  belongs_to :form_response

end
