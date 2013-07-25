class Brother < ActiveRecord::Base
     has_attached_file :photo, :styles => { :thumb => "120x150#", :bw =>"120x150#", :show=> "190x*>"},
     :convert_options => {:all => "-strip", :bw => "-colorspace Gray"},
     :url => "/brothers/:id/:style/:basename.:extension",
     :path => ":rails_root/public/brothers/:id/:style/:basename.:extension" 
     
     validates_attachment_presence :photo  
     validates_attachment_size :photo, :less_than => 5.megabytes  
     validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
     
     attr_accessible :pledge_class, :pledge_name, :name, :ethnicity, :crossing, :hometown, :photo, :bio
end
