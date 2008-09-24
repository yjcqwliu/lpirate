# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  require "pp"
  helper :all # include all helpers, all the time
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  #protect_from_forgery # :secret => '7982602486defa6700eb432a7a0095d7'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  #platform = "xiaonei"
     
  #require  "platform/#{platform}.rb"
  acts_as_xiaonei_controller
  before_filter :set_current_user

  def set_current_user
    if @current_user.nil?
      @current_user = User.find_or_create_by_xid(xiaonei_session.user.to_i)
	  #pp("===========current_user:#{@current_user.inspect},xiaonei_session:#{@xiaonei_session.inspect}=============")
      if @current_user.session_key != xiaonei_session.session_key
      @current_user.session_key = xiaonei_session.session_key
       @current_user.save
      end
    end
	#if @current_user.friend_ids.nil? or @current_user.friend_ids.size == 0 or @current_user.updated_at > (Time.now - 48.hour)
   #     res = xiaonei_session.invoke_method("xiaonei.friends.get")
    #    if res.kind_of? Xiaonei::Error
    #      @current_user.friend_ids = [] if @current_user.friend_ids.empty?
    #    else
    #      @current_user.friend_ids = res
    #    end
   #     @current_user.save
	# end 

  end
  #before_filter :set_current_user
  #def set_current_user
  #@current_user=User.login(1)
  #end
  
  def current_user
    @current_user
  end
  def ensure_admin
    if not @current_user.admin
      xn_redirect_to(url_for(:controller => "homes", :action => :show))
    end
  end
  
  def xn_redirect_to(to_url,feilds={})
    path = "#{to_url}?"
        feilds.each do |key,value|
	     path += "#{key}=#{URI.escape(value)}&"
        end
    render :text => "<xn:redirect url=\"#{path}\"/>"
  end

  def showmessage(feilds,to_url)
        path = "#{to_url}?"
        feilds.each do |key,value|
	     path += "#{key}=#{URI.escape(value)}&"
        end
	render :text => "<xn:redirect url=\"#{path}\"/>"
	return;
  end
end
