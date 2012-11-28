class Joinme::RequestAuthCode < Joinme::APIRequest

  attr_reader :auth_code

  def initialize email, password
    @email     = email
    @password  = password
    invoke!
  end

private

  def invoke!
    parts = api_call('requestAuthCode', 'email' => @email, 'password' => @password).split("\n")
    if parts.first == 'OK'
      @auth_code = parts.last.split(': ').last
    end
  end

end