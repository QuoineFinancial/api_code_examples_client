require 'uri'
require 'net/http'
require 'time'
require 'jwt'

uri = URI.parse("https://api.quoine.com")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

token_id = 'YOUR_API_TOKEN_ID'
user_secret = 'YOUR_API_SECRET'
path = '/withdrawals'
body = {
  "auth_code" => "1731C",
  "withdrawal" => {
    "currency" => "USD",
    "amount" => "10.0",
    "bank_account_id" => 624
  }
}

auth_payload = {
  path: path,
  nonce: DateTime.now.strftime('%Q'),
  token_id: token_id
}

signature = JWT.encode(auth_payload, user_secret, 'HS256')
request = Net::HTTP::Post.new(path)
request.body = body.to_json
request.add_field('X-Quoine-API-Version', '2')
request.add_field('X-Quoine-Auth', signature)
request.add_field('Content-Type', 'application/json')

response = http.request(request)
p response.body
