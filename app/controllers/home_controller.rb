class HomeController < ApplicationController
	require 'pp'
	def index
		if id = params[:id]
		    @user  = User.login(id)
		else
		    @user = @current_user
		end
		if params[:help] 
		@notice ="这是你的小岛，一共有四个码头，其中前三个是私人码头，你的好友可以到你的私人码头上来抢劫，你必须保卫你的码头不受攻击。当然，你也可以去抢劫你的好友的码头，别让他发现了哦。"
		end
		
	end
	
	def me
	   @user = @current_user
	   render :action => :index
	end
	
	def friend
	   @user  = User.login(@current_user.friend_ids.rand)
	   render :action => :index
	end
	
	def myship
	   
	end
	
	def help
	
	end
	
	def invite
	    ids=params[:ids]||[]
		ids.each do |id|
			User.login(id,@current_user.xid)
		end
	    @notappuser = User.find(:all,
		                        :conditions => [" xid in (?) and session_key is not null ",@current_user.friend_ids]
							    )
	end
	
	
	def rob
	    
		
		@user = User.find(params[:id])
		
		     
			 if (usership=params[:usership]) == nil
				 xn_redirect_to("home/index/#{@user.xid}",{:notice => "抢劫前请选择一只空闲的船，如果你没有空闲的船，<a href=\"#{url_for  :controller => :shop,:action => :index}\">去买一艘吧？</a>"})
			 else
				 @usership = Usership.find(usership[:id])
				 if false # @usership.robof != nil and @usership.robof !=0
					 #xn_redirect_to("home/index/#{@user.xid}",{:notice => "抢劫前请选择一只空闲的船，如果你没有空闲的船，<a href=\"#{url_for  :controller => :shop,:action => :index}\">去买一艘吧？</a>"})
				 else
					 
					 dock = params[:dock]
					 #pp("-------------usership:#{@usership.inspect}------------")
					 
					 rob_balance(@usership)
					 #重新开始抢劫
					 case dock
						when "抢劫码头1"
						   if (@user.dock1 == nil or @user.dock1 == 0 ) and ! isrobself
						         
								 @user.dock1 = usership[:id]
								 @user.dock1_time = Time.now
								 @user.save
								
								 @usership.robof = @user.xid
								 @usership.save
						   end
						when "抢劫码头2"
						   if (@user.dock2 == nil or @user.dock2 == 0 ) and ! isrobself
								 @user.dock2 = usership[:id]
								 @user.dock2_time = Time.now
								 @user.save
								
								 @usership.robof = @user.xid
								 @usership.save
						   end
						when "抢劫码头3"
						   if (@user.dock3 == nil or @user.dock3 == 0 ) and ! isrobself
								 @user.dock3 = usership[:id]
								 @user.dock3_time = Time.now
								 @user.save
								
								 @usership.robof = @user.xid
								 @usership.save
						   end
						when "停靠"
						   if (@user.dock4 == nil or @user.dock4 == 0 ) and ! isrobself
								 @user.dock4 = usership[:id]
								 @user.dock4_time = Time.now
								 @user.save
								
								 @usership.robof = @user.xid
								 @usership.save
						   end
						when "夺回码头1"
						   if @user.dock1  and @user.dock1 > 0  and  isrobself 
						         rob_balance(Usership.find(@user.dock1))
						   
						   end
						when "夺回码头2"
						   if @user.dock2  and @user.dock2 > 0  and  isrobself 
						         rob_balance(Usership.find(@user.dock2))
						   
						   end
						when "夺回码头3"
						   if @user.dock3  and @user.dock3 > 0  and  isrobself 
						         rob_balance(Usership.find(@user.dock3))
						   
						   end
						when "赶跑TA"
						   if @user.dock4  and @user.dock4 > 0  and  isrobself 
						         rob_balance(Usership.find(@user.dock4))
						   
						   end
				     end
				 xn_redirect_to("home/index/#{@user.xid}")
				 end 
				
			 end
		 
	end
private	
def isrobself
if @user.xid == @current_user.xid 
true
else
false
end
		    # xn_redirect_to("home/index",{:notice => "不能抢劫自己"})

end
end
