class Clan < ActiveRecord::Base
  validates_presence_of :tag
  before_create :load_data 
  # after_initialize :refresh

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
    { :"Authorization".to_s => "Bearer #{ENV['CLASH_API_TOKEN'] || 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjJiNDNlYWU4LTczZWUtNDgwOS05NzBiLTRmNDMxM2ZhYjgxZSIsImlhdCI6MTQ1NDgzNDQyNywic3ViIjoiZGV2ZWxvcGVyLzQ2OTIxMmRhLWEzOTItZDk2Ni0zMjcxLWYyZmExODUwYTFhZCIsInNjb3BlcyI6WyJjbGFzaCJdLCJsaW1pdHMiOlt7InRpZXIiOiJkZXZlbG9wZXIvc2lsdmVyIiwidHlwZSI6InRocm90dGxpbmcifSx7ImNpZHJzIjpbIjczLjI0MS4xOTIuNzUiXSwidHlwZSI6ImNsaWVudCJ9XX0.oOF0a3FQV9gGwq1y5lizJfnAX7MCArlCMQIUUUKs5gICbqRVu5n5tjFy7k75_hhO27DDsQHGbeRvoQ9csnNs_g
'}" }
  end
end


