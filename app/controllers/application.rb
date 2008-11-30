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
  def set_current_user
		  @current_user = User.login(xiaonei_session.user)
		  if @current_user.session_key != xiaonei_session.session_key
		  	@current_user.session_key = xiaonei_session.session_key
			@current_user.friend_ids_will_change!
		  	@current_user.save
		  end
		  pp "------#{@current_user.friend_ids.type}---"
  end
  def login_current_user
		if @current_user.nil?
		  @current_user = User.login(xiaonei_session.user)
		  if @current_user.session_key != xiaonei_session.session_key
		  @current_user.session_key = xiaonei_session.session_key
		  end
		  
		end
		update_friend_ids
		initdata #登陆游戏时的一些数据初始化			
		@current_user.friend_ids_will_change!
		@current_user.save		
  end
  def current_user
    @current_user
  end

  
  def xn_redirect_to(to_url,feilds={})
    path = to_url
	path += "?" if ! feilds.blank?
        feilds.each do |key,value|
			if key && value
				 path += "#{key}=#{URI.escape(value)}&"
			end
		end
    render :text => "<xn:redirect url=\"#{path}\"/>"
	#render :text => "你没有权限操作"
  end

  def balance(usership,upkeep = 0)
	 #结算之前抢劫赚的钱

					 if usership.robof && usership.robof >0 
					     
							   if usership.robtime then
											cmp_time = Time.now - usership.robtime	
											cmp_money = ( conversion(cmp_time,usership.capacity,usership.robspeed)*(1 - upkeep) ).to_i
											@current_user.gold += cmp_money	
											@current_user.friend_ids_will_change!							
											@current_user.save
								end
								usership.robdock = 0
								usership.robuser.save
								usership.robof = 0
								usership.save
								cmp_money
					 end
	end
	
	def conversion(cmp_time,top=1000,speed=200) #传入时间差
	
	    time = fulltime(top , speed)*3600 #抢满的时间，此处为 小时*3600
		tt = cmp_time / time
		#pp("@@@@@@tt:#{tt}@@@@@time:#{time}@@@@cmp_time:#{cmp_time}@@")
		if tt > 1 
		   @conversion =  top
		else
		   @conversion = top * tt
		end 
		@conversion.to_i
	end

	def fulltime(top,speed)
	    t = top / (speed * 1.0)
	    #pp("----t:#{t}-----")
	    t
	end
	
	def rob_balance(usership,to_user=0)
	    if usership.robof && usership.robof >0 
			notice = Notice.new()
			notice.user_id = current_user.id
			notice.from_xid = current_user.xid
			notice.to_xid = usership.robof 
			money = balance(usership,@current_user.upkeep)
			notice.column1 = money
			notice.column2 = usership.name
			notice.ltype = 1
			notice.save
			#增加经验
			if usership.captain
			    usership.captain.add_exp(@current_user,money)
			end
			money
		end
	    
	end
	
	def reseize_balance(usership)
	    notice = Notice.new()
		notice.user_id = current_user.id
		notice.from_xid = current_user.xid
		notice.to_xid = usership.user.xid
		money = balance(usership)
		notice.column1 = money
		notice.ltype = 2
		notice.save
		
	end
	
	def url_to_island(xid)
	    url = "<a href=\"#{url_for  :controller => :home , :action => :friend ,:id => xid }\"><xn:name uid=\"#{xid}\" /></a>"
	end
	
	

	def initdata
		pp "-----init data---"
	    ###############贸易相关数据初始化#################
    	###############贸易相关数据初始化结束#################
		invite_blance #处理邀请数据
		login_award   #登陆奖励
	end
	def login_award 
	    if !@current_user.award_updated_at or @current_user.award_updated_at < (Time.now - 3.hour)
		    @current_user.gold += 300
			@current_user.award_updated_at=Time.now
			notice = Notice.new()
			notice.user_id = current_user.id
			notice.from_xid = current_user.xid
			notice.to_xid = current_user.xid
			notice.ltype = 10
			notice.save
		end
	end
	def invite_blance
	#邀请奖励
	    if @current_user.invite && @current_user.invite != 0
		    invite_array = @current_user.invite || []
			invite_user = User.find(:all,
			                        :conditions => [" xid in (?)",invite_array]
								   )
			invite_user.each do |iu|
			    iu.gold += 3000
				iu.pgold += 1
				iu.save
				        notice = Notice.new()
						notice.user_id = iu.id
						notice.from_xid = current_user.xid
						notice.to_xid = iu.xid
						notice.ltype = 3
						notice.save
			end
					
		end 
        @current_user.invite = 0
	end
	def rescue_action_in_public(exception)
		case exception.class.name
		when
	'ActiveRecord::RecordNotFound','::ActionController::UnknownAction','::ActionController::RoutingError' 
			 RAILS_DEFAULT_LOGGER.error("404 displayed")
			 render(:file => "#{RAILS_ROOT}/public/404.html") 
		 else
			RAILS_DEFAULT_LOGGER.error("500 displayed")
			render(:file => "#{RAILS_ROOT}/public/500.html")
		end
	end

	def rescue_action_locally(exception)
		case exception.class.name
		when 'ActiveRecord::RecordNotFound','::ActionController::UnknownAction','::ActionController::RoutingError' 
			RAILS_DEFAULT_LOGGER.error("404 displayed")
			render(:file => "#{RAILS_ROOT}/public/404.html") 
		 else
			RAILS_DEFAULT_LOGGER.error("500 displayed")
			render(:file => "#{RAILS_ROOT}/public/500.html")
		end
    end
	
	def update_friend_ids
			if (@current_user.friend_ids.blank? or @current_user.friend_ids.type == String) or @current_user.updated_at < Time.now - 8.hour
					pp "-----use friend api--@current_user.friend_ids.type:#{@current_user.friend_ids.type}-"
					res = xiaonei_session.invoke_method("xiaonei.friends.get")
					if res.kind_of? Xiaonei::Error
					  @current_user.friend_ids = [] if @current_user.friend_ids.blank?
					else
					  @current_user.friend_ids = res
					end
			else
					pp "----don't-use friend api--@current_user.friend_ids.type:#{@current_user.friend_ids.type}-"
			end
	end
end
