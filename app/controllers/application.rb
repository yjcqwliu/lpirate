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
	  if params[:controller] != "ships" then
			if @current_user.nil?
			  @current_user = User.login(xiaonei_session.user.to_i)
			  
			  if @current_user.session_key != xiaonei_session.session_key
			  @current_user.session_key = xiaonei_session.session_key
			   @current_user.save
			  end
			end
			if @current_user.friend_ids.nil? or @current_user.friend_ids.size == 0 or @current_user.updated_at > (Time.now - 48.hour)
				res = xiaonei_session.invoke_method("xiaonei.friends.get")
				#pp("===========res:#{res.inspect}=============")
			   if res.kind_of? Xiaonei::Error
				  @current_user.friend_ids = [] if @current_user.friend_ids.empty?
				else
				  @current_user.friend_ids = res
				  #@current_user.friend_ids = ["13241324","2352452354","352354"]
				end
				@current_user.save
			end 
	   else
	     #pp("-----cookie:#{cookies[:admin]}---")
		 @admin = cookies[:admin]
		 if !@admin or @admin == ""  then
			 @admin = params[:admin]
			 cookies[:admin] = @admin 
		 end 
		 #pp("-----admin:#{@admin}---")
	   end
	

  end
  #before_filter :set_current_user
  #def set_current_user
  #@current_user=User.login(1)
  #end
  
  def current_user
    @current_user
  end
  def ensure_admin
    #if not @current_user.admin
	 if @admin != "yjcqwliu" 
      #xn_redirect_to("homes/index",{:notice => "你没有权限"})
	  redirect_to(:controller => :home,:action => :index)
    end
  end
  
  def xn_redirect_to(to_url,feilds={})
    path = "#{to_url}?"
        feilds.each do |key,value|
	     path += "#{key}=#{URI.escape(value)}&"
        end
    render :text => "<xn:redirect url=\"#{path}\"/>"
	#render :text => "你没有权限操作"
  end

  	def rob_balance(usership)
	 #结算之前抢劫赚的钱

					 if usership.robof && usership.robof >0 
					     
							   if usership.robtime then
											cmp_time = Time.now - usership.robtime		
											@current_user.gold += conversion(cmp_time)										
											@current_user.save
								end
								usership.robdock = 0
								usership.robuser.save
								usership.robof = 0
								usership.save
					 end
	end
	
	def conversion(cmp_time) #传入时间差
	    time = 18000 #抢满的时间，此处为 小时*3600，即3小时
		tt = cmp_time / time
		if tt > 1 
		   @conversion =  1000
		else
		   @conversion = 1000 * tt
		end 
	end
end
