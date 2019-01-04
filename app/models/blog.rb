class Blog < ApplicationRecord
    validates :title, presence: true
    mount_uploader :blog_image, BlogImageUploader
end
