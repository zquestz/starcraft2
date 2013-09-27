require 'base64'
require 'hmac-sha1'
require 'addressable/uri'

class WebResource
  def self.get(url)
    private_key = ENV['STARCRAFT2_API_PRIVATE_KEY']
    public_key = ENV['STARCRAFT2_API_PUBLIC_KEY']
    date = Time.now.gmtime.rfc2822.gsub("-0000", "GMT")
    response = if public_key && private_key
      HTTParty.get(url,
       :headers => { "Date" => date,
                     "Authorization" => "BNET #{public_key}:#{signature(url, private_key, date)}"})
    else
      HTTParty.get(url)
    end
  end

  def self.signature(url, private_key, date)
    url_path = ::Addressable::URI.parse(url).path

    signature = <<-EOF
GET
#{date}
#{url_path}
EOF

    hmac = HMAC::SHA1.new(private_key.encode('UTF-8'))
    hmac.update(signature)

    Base64.encode64(hmac.digest)
  end
end
