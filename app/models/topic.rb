class Topic < ActiveRecord::Base
  extend FriendlyId
  belongs_to :forum
  friendly_id :title, use: [:slugged, :finders]
end
