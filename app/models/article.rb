class Article < ActiveRecord::Base
  extend FriendlyId
  scope :recent, -> { where("created_at >= ?", Date.today - 30.days).order(created_at: :desc) }
  belongs_to :user
  friendly_id :title, use: [:slugged, :finders]
end
