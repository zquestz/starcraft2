class WebResource
  def self.get(url)
    response = HTTParty.get(url)
  end
end
