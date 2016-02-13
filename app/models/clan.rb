class Clan < ActiveRecord::Base
  validates_presence_of :tag
  before_create :load_data 
  after_initialize :refresh

  def player(name)
    memberList.select { |x| x["name"].downcase == name.downcase }.first
  end

  private
  def refresh
    return unless Rails.env.development?
    update_attribute(:data, load_data) if updated_at.present? && updated_at < 10.seconds.ago
  end

  def load_data
    # url = "https://api.clashofclans.com/v1/clans/%238PVC09UJ"
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
    galvanize = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6ImVjMmU3OGFkLTAzN2EtNGQ3Yy04NmQzLTM3ZDU4ODNhMjdkZSIsImlhdCI6MTQ1NTIyMDM1OCwic3ViIjoiZGV2ZWxvcGVyLzQ2OTIxMmRhLWEzOTItZDk2Ni0zMjcxLWYyZmExODUwYTFhZCIsInNjb3BlcyI6WyJjbGFzaCJdLCJsaW1pdHMiOlt7InRpZXIiOiJkZXZlbG9wZXIvc2lsdmVyIiwidHlwZSI6InRocm90dGxpbmcifSx7ImNpZHJzIjpbIjEyOC4xNzcuMTEzLjEwNiJdLCJ0eXBlIjoiY2xpZW50In1dfQ.OqpmwQpzAq4CZf4xcrKo3s292UwX7eg9GTTdTWQno-odrBnv9-e79FHPG2iz3NI3q27IixQLOaEOC4OG_ih0Ew'
    home = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjBjZGVhOTVmLWFiZTktNDFlZi04ZDQ3LTJlYzUwODVjNGE4MSIsImlhdCI6MTQ1NTA3NDkxMSwic3ViIjoiZGV2ZWxvcGVyLzQ2OTIxMmRhLWEzOTItZDk2Ni0zMjcxLWYyZmExODUwYTFhZCIsInNjb3BlcyI6WyJjbGFzaCJdLCJsaW1pdHMiOlt7InRpZXIiOiJkZXZlbG9wZXIvc2lsdmVyIiwidHlwZSI6InRocm90dGxpbmcifSx7ImNpZHJzIjpbIjczLjI0MS4xOTIuNzUiLCIxMjguMTc3LjExMy4xMDYiLCI1NC4xNTkuMTYzLjE1MyIsIjUwLjYzLjIwMi40NCJdLCJ0eXBlIjoiY2xpZW50In1dfQ.dhDBNq-m70BApmvHpZSSj6IUGR3yAZMR79aZK8wY_Q8jOtEursM8YgoBS1aKBrypY74F82K-RJr3RgsMMwbjjA'
    { :"Authorization".to_s => "Bearer #{home}" }
  end
end
