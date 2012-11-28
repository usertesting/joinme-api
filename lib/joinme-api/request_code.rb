class Joinme::RequestCode < Joinme::APIRequest

  def initialize auth_code
    @auth_code = auth_code
    @params    = {}
    invoke!
  end

  def code
    @params['code'] || ""
  end

  def ticket
    @params['ticket'] || ""
  end

private

  def invoke!
    parts = api_call('requestCode', 'authcode' => @auth_code).split("\n")
    if parts.first == 'OK'
      parts.each do |param|
        key, value = param.split(': ')
        @params[key.downcase] = value
      end
    end
  end

end