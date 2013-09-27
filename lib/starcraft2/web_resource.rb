require 'base64'
require 'digest/hmac'
require 'addressable/uri'

class WebResource
  def self.get(url)
    private_key = ENV['STARCRAFT2_API_PRIVATE_KEY']
    public_key = ENV['STARCRAFT2_API_PUBLIC_KEY']
    response = if public_key && private_key
      HTTParty.get(url,
        :headers => { "Authorization" => "BNET #{public_key}:#{signature(url, private_key)}" })
    else
      HTTParty.get(url)
    end
  end

  def self.signature(url, private_key)
    url_path = ::Addressable::URI.parse(url).path

    signature = <<-EOF
GET
#{Time.now.gmtime.rfc2822.gsub("-0000", "GMT")}
#{url_path}
EOF
    hd = Digest::HMAC.hexdigest(signature, private_key.encode('UTF-8'), Digest::SHA1)

    Base64.encode64(hd).chomp
  end
end
