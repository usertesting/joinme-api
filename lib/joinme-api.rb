require 'uri'
require 'net/http'

class JoinmeApi
  attr_accessor :email, :password

  def initialize(email, password)
    @email    = email
    @password = password
  end

  def login
    api_call('login', 'email' => email, 'password' => password) == 'OK'
  end

  def request_auth_code
    parts = api_call('requestAuthCode', 'email' => email, 'password' => password).split("\n")
    if parts.first == 'OK'
      parts.last.split(': ').last
    end
  end

  def request_code(auth_code = request_auth_code)
    codes = code_and_ticket(auth_code)
    codes['code']
  end

  def download(code=nil, ticket=nil)
    codes = {}
    if code and ticket
      codes['code'] = code
      codes['ticket'] = ticket
    else
      codes = code_and_ticket
    end

    if codes['code'] and codes['ticket']
      "https://secure.join.me/download.aspx?code=%s&ticket=%s" % [codes['code'], codes['ticket']]
    end
  end
  alias :download_url :download

  private

  def code_and_ticket(auth_code = request_auth_code)
    parts = api_call('requestCode', 'authcode' => auth_code).split("\n")
    params = {}
    if parts.first == 'OK'
      parts.each do |param|
        key, value = param.split(': ')
        params[key.downcase] = value
      end
    end
    params
  end

  def api_call(call, params)
    uri = URI("https://secure.join.me/API/#{call}.aspx")
    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data(params)
    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req)
    end
    res.body.to_s
  end

end
