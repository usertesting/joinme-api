class Joinme::Download

  def initialize code, ticket
    @code   = code
    @ticket = ticket
  end

  def url
    "https://secure.join.me/download.aspx?code=#{@code}&ticket=#{@ticket}&webdownload=true"
  end

end