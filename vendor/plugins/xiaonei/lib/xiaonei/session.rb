module Xiaonei
  class Session
    attr_accessor :auth_token
    attr_reader :session_key
    attr_reader :expires
    attr_reader :user
    attr_reader :time
    attr_reader :api_key
    attr_reader :in_iframe
    attr_reader :added
    
    def initialize(params)
      if params["xn_sig_session_key"]
        @expires = params["xn_sig_expires"] == "1"
        @session_key = params["xn_sig_session_key"]
        @user = params["xn_sig_user"]
        @time = params["xn_sig_time"]
        @api_key = params["xn_sig_api_key"]
        @in_iframe = params["xn_sig_in_iframe"] == "1"
        @added = params["xn_sig_added"] == "1"
      end
    end
    
    def api_key
      ENV['XIAONEI_API_KEY']
    end

    def canvas_path
      ENV['XIAONEI_RELATIVE_URL_ROOT']
    end
    
    def invoke_method(method, params = {})
      xn_params = { 
        :method => method,
        :api_key => api_key,
        :session_key => session_key,
        :call_id => Time.now.to_i,
        :v => "1.0" }
      xn_params.merge!(params) if params
      begin 
        Parse.new.process(Service.new.post(xn_params).body)
      rescue Exception => exp
        Xiaonei::Error.new
      end
    end

  end
end
