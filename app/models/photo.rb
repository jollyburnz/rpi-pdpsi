class Photo < ActiveRecord::Base
  belongs_to :gallery
  has_attached_file :image, 
  :styles => { :thumb  => "110x120#",:bw  => "110x120#", :original => "640x640>" },
  :convert_options => {:all => "-strip", :bw => "-brightness-contrast -20"},
  :url => "/gallery/:style/:basename.:extension",
  :path => ":rails_root/public/gallery/:style/:basename.:extension"
end
