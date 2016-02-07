class Application < ActiveRecord::Base
  validates_presence_of :username, message: "Please enter a username"
  validates_presence_of :about, message: "Please tell us about yourself"
  validates :email, presence: true, uniqueness: true
  validates :thlevel, numericality: { greater_than: 0, less_than_or_equal_to: 11, message: "Please select a town hall level" }
  validates :level, numericality: { greater_than: 0, less_than_or_equal_to: 500, message: "Please enter a valid player level" }
end
