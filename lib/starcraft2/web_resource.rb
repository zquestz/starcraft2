require 'base64'
require 'hmac-sha1'

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
    hmac = HMAC::SHA1.new(private_key)
    hmac.update(signature.encode('UTF-8'))

    Base64.encode64("#{hmac.digest}")
  end
end
