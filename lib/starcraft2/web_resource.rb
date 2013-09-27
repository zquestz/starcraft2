require 'base64'
require 'digest/hmac'

class WebResource
  def self.get(url)
    private_key = ENV['STARCRAFT2_API_PRIVATE_KEY']
    public_key = ENV['STARCRAFT2_API_PUBLIC_KEY']
    response = if public_key && private_key
      HTTParty.get(url, headers: {"Authorization" => "BNET #{public_key}:#{signature(url, private_key)}"})
    else
      HTTParty.get(url)
    end
  end

  def self.signature(url, private_key)
    url_path = Addressable::URI.parse(url).path

    signature = <<-EOF
GET
#{Time.now.rfc2822}
#{url_path}
EOF
    hd = Digest::HMAC.hexdigest(signature.encode('UTF-8'), private_key, Digest::SHA1)

    Base64.encode64("#{hd}")
  end
end
