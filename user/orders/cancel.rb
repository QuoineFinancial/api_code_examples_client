require 'uri'
require 'net/http'
require 'time'
require 'jwt'

uri = URI.parse("https://api.quoine.com")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

token_id = 'YOUR_API_TOKEN_ID'
user_secret = 'YOUR_API_SECRET'
path = '/orders/{your order id}/cancel'

auth_payload = {
  path: path,
  nonce: DateTime.now.strftime('%Q'),
  token_id: token_id
}

signature = JWT.encode(auth_payload, user_secret, 'HS256')

request = Net::HTTP::Put.new(path)
request.add_field('X-Quoine-API-Version', '2')
request.add_field('X-Quoine-Auth', signature)
request.add_field('Content-Type', 'application/json')

response = http.request(request)
p response.body
