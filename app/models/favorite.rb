class Favorite < ApplicationRecord
    belongs_to :user
    belongs_to :blog
    mount_uploader :blog_image, BlogImageUploader
    mount_uploader :user_image, UserImageUploader

end
