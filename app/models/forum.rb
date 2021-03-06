class Forum < ActiveRecord::Base
  extend FriendlyId
  belongs_to :user
  has_many :topics
  friendly_id :title, use: [:slugged, :finders]
end
