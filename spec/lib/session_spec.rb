require 'spec_helper'

describe Joinme::Session do

  let(:auth_code) { "abc123def456" }
  let(:code)      { "123456789" }
  let(:email)     { "ryan@ryan.com" }
  let(:password)  { "password" }
  let(:ticket)    { "123098456765" }
  let(:session)   { Joinme::Session.new email, password }

  context "a new session" do

    before do
      stub_request(:post, "https://secure.join.me/API/requestAuthCode")
          .with(body: { email: email, password: password })
          .to_return(status: 200, body: "OK\nAUTHCODE: #{auth_code}")

      stub_request(:post, "https://secure.join.me/API/requestCode")
        .with(body: { authcode: auth_code })
        .to_return(status: 200, body: "OK\nCODE: #{code}\nTICKET: #{ticket}")
    end

    describe "#presenter_url" do
      it "should return the download url for the unique session" do
        session.presenter_url.should eq("https://secure.join.me/download.aspx?code=#{code}&ticket=#{ticket}&webdownload=true")
      end
    end

    describe "#participant_url" do
      it "should return the join.me url for the participant to join online" do
        session.participant_url.should eq("http://join.me/#{code}")
      end
    end

  end

end