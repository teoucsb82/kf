class Clan < ActiveRecord::Base
  validates_presence_of :tag
  before_create :load_data 
  after_initialize :refresh

  private
  def refresh
    update_attribute(:data, load_data) if updated_at.present? && updated_at < 10.seconds.ago
  end

  def load_data
    url = "https://api.clashofclans.com/v1/clans/%23#{self.tag}"
    begin
      response = HTTParty.get(url, headers: Clan.authorization )
      self.data = response.to_json
    rescue
      Rails.logger.info "Could not connect to API"
      self.data
    end
  end

  def method_missing(m, *args, &block)
    info = JSON.parse(data)
    return super unless m.in?(info.keys.map(&:to_sym))
    return info[m.to_s]
  end

  def self.authorization
    { :"Authorization".to_s => "Bearer #{ENV['CLASH_API_TOKEN']}" }
  end
end
