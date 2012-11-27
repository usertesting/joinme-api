require 'spec_helper'

describe JoinmeApi do
  before :each do
    @api = JoinmeApi.new('p@z.com','qawsed')
  end

  describe "#new" do
    it "should require email and password" do
      expect {
        JoinmeApi.new
      }.to raise_error(ArgumentError)
    end
  end

  describe "#login" do
    it "should hit the login api" do
      stub_request(:post, "https://secure.join.me/API/login")
        .with(:body => {"email"=>"p@z.com", "password"=>"qawsed"})
        .to_return(:status => 200, :body => "OK")

      @api.login.should be_true
    end

    it "should handle errors" do
      stub_request(:post, "https://secure.join.me/API/login")
        .with(:body => {"email"=>"p@z.com", "password"=>"qawsed"})
        .to_return(:status => 200, :body => "ERROR: 4; Invalid email or password")

      @api.login.should be_false
    end
  end

  describe "#request_auth_code" do
    it "should return an auth code" do
      stub_request(:post, "https://secure.join.me/API/requestAuthCode")
        .with(:body => {"email"=>"p@z.com", "password"=>"qawsed"})
        .to_return(:status => 200, :body => "OK\nAUTHCODE: usbzlurwujpw2xbfy1xc2cjiuovaankw")

      @api.request_auth_code.should == 'usbzlurwujpw2xbfy1xc2cjiuovaankw'
    end

    it "should handle errors" do
      stub_request(:post, "https://secure.join.me/API/requestAuthCode")
        .with(:body => {"email"=>"p@z.com", "password"=>"qawsed"})
        .to_return(:status => 200, :body => "ERROR: 4; Invalid email or password")

      @api.request_auth_code.should be_nil
    end
  end

  describe "#request_code" do
    it "should return an meeting and ticket codes" do
      # stub the request auth code call
      stub_request(:post, "https://secure.join.me/API/requestAuthCode")
        .with(:body => {"email"=>"p@z.com", "password"=>"qawsed"})
        .to_return(:status => 200, :body => "OK\nAUTHCODE: usbzlurwujpw2xbfy1xc2cjiuovaankw")

      # stub the request meeting code
      stub_request(:post, "https://secure.join.me/API/requestCode")
        .with(:body => {"authcode"=>"usbzlurwujpw2xbfy1xc2cjiuovaankw"})
        .to_return(:status => 200, :body => "OK\nCODE: 101494581\nTICKET: 432412671")

      @api.request_code.should == '101494581'
    end

    it "should handle errors" do
      # stub the request auth code call
      stub_request(:post, "https://secure.join.me/API/requestAuthCode")
        .with(:body => {"email"=>"p@z.com", "password"=>"qawsed"})
        .to_return(:status => 200, :body => "OK\nAUTHCODE: usbzlurwujpw2xbfy1xc2cjiuovaankw")

      stub_request(:post, "https://secure.join.me/API/requestCode")
        .with(:body => {"authcode"=>"usbzlurwujpw2xbfy1xc2cjiuovaankw"})
        .to_return(:status => 200, :body => "ERROR: 4; Invalid email or password")

      @api.request_code.should be_nil
    end

    it "should accept the request code as a parameter" do
      stub_request(:post, "https://secure.join.me/API/requestCode")
        .with(:body => {"authcode"=>"usbzlurwujpw2xbfy1xc2cjiuovaankw"})
        .to_return(:status => 200, :body => "ERROR: 4; Invalid email or password")

      @api.request_code('usbzlurwujpw2xbfy1xc2cjiuovaankw').should be_nil
    end
  end

  describe "#download and #download_url" do
    it "should return the download url" do
      # stub the request meeting code
      stub_request(:post, "https://secure.join.me/API/requestCode")
        .with(:body => {"authcode"=>"usbzlurwujpw2xbfy1xc2cjiuovaankw"})
        .to_return(:status => 200, :body => "OK\nCODE: 101494581\nTICKET: 432412671")

      url = "https://secure.join.me/download.aspx?code=101494588&ticket=432412675"
      @api.download('101494588','432412675').should == url
      @api.download_url('101494588','432412675').should == url
    end

    it "should return the download url" do
      # stub the request meeting code
      stub_request(:post, "https://secure.join.me/API/requestCode")
        .with(:body => {"authcode"=>"usbzlurwujpw2xbfy1xc2cjiuovaankw"})
        .to_return(:status => 200, :body => "OK\nCODE: 101494581\nTICKET: 432412671")

      url = "https://secure.join.me/download.aspx?code=101494588&ticket=432412675"
      @api.download('101494588','432412675').should == url
    end

    it "should return the download url" do
      # stub the request auth code call
      stub_request(:post, "https://secure.join.me/API/requestAuthCode")
        .with(:body => {"email"=>"p@z.com", "password"=>"qawsed"})
        .to_return(:status => 200, :body => "OK\nAUTHCODE: usbzlurwujpw2xbfy1xc2cjiuovaankw")

      # stub the request meeting code
      stub_request(:post, "https://secure.join.me/API/requestCode")
        .with(:body => {"authcode"=>"usbzlurwujpw2xbfy1xc2cjiuovaankw"})
        .to_return(:status => 200, :body => "OK\nCODE: 101494588\nTICKET: 432412675")

      url = "https://secure.join.me/download.aspx?code=101494588&ticket=432412675"
      @api.download.should == url
    end

    it "should handle errors" do
      # stub the request auth code call
      stub_request(:post, "https://secure.join.me/API/requestAuthCode")
        .with(:body => {"email"=>"p@z.com", "password"=>"qawsed"})
        .to_return(:status => 200, :body => "OK\nAUTHCODE: usbzlurwujpw2xbfy1xc2cjiuovaankw")

      # stub the request meeting code
      stub_request(:post, "https://secure.join.me/API/requestCode")
        .with(:body => {"authcode"=>"usbzlurwujpw2xbfy1xc2cjiuovaankw"})
        .to_return(:status => 200, :body => "ERROR: 4; Invalid email or password")

      @api.download_url.should be_nil
    end
  end
end
