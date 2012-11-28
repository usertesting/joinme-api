class Joinme::Session

  def initialize email, password
    @email    = email
    @password = password
  end

  def presenter_url
    Joinme::Download.new(request_code.code, request_code.ticket).url
  end

  def participant_url
    "http://join.me/#{request_code.code}"
  end

private

  def request_code
    @request_code ||= Joinme::RequestCode.new request_auth_code.auth_code
  end

  def request_auth_code
    @request_auth_code ||= Joinme::RequestAuthCode.new @email, @password
  end

end