class Photo < ActiveRecord::Base
  has_attached_file :image, styles: {medium: 'x100', thumb: 'x60'},
    default_url: '/images/:style/missing.png',
    url: '/photos/:event/:style/:filename'
end
