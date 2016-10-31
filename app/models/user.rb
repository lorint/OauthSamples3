class User < ApplicationRecord
  belongs_to :default_social_medium, class_name: "SocialMedium", required: false
  has_many :social_media
end
