class Joinme::APIRequest

  def api_call(call, params)
    uri = URI("https://secure.join.me/API/#{call}")
    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data(params)
    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req)
    end
    res.body.to_s
  end

end