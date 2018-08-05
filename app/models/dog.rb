class Dog < ApplicationRecord
    mount_uploader :image, ImageUploader
end
