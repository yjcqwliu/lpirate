class HomeController < ApplicationController
	require 'pp'
	def index
		@user = @current_user
		@mynotice = Notice.find(:all,
		                     :conditions => [" from_xid in (?,?) or to_xid in (?,?)",@current_user.friend_ids,@current_user.xid,@current_user.friend_ids,@current_user.xid],
							  :order => " updated_at desc ",
							  :limit => 20
							 )
	end
	
	def me
	   @user = @current_user
	   		@mynotice = Notice.find(:all,
		                     :conditions => [" from_xid in (?,?) or to_xid in (?,?)",@current_user.friend_ids,@current_user.xid,@current_user.friend_ids,@current_user.xid],
							  :order => " updated_at desc ",
							  :limit => 20
							 )
		
	   render :action => :index
	   
	end
	
	def friend
	   if id = params[:id]
		    @user  = User.login(id)
		else
		    @user  = User.login(@current_user.friend_ids.rand)
		end	   
		@mynotice = Notice.find(:all,
		                     :conditions => [" from_xid in (?,?) or to_xid in (?,?)",@current_user.friend_ids,@current_user.xid,@current_user.friend_ids,@current_user.xid],
							  :order => " updated_at desc ",
							  :limit => 20
							 )
	   render :action => :index
	end
	
	def myship
	   
	end
	
	def help
	    @friend = current_user.friend_ids.rand
	end
	
	def invite
	    if ids=params[:ids]
			ids.each do |id|
				User.login(id,@current_user.xid)
			end
			 xn_redirect_to("home/invite",{"notice" => "成功邀请了#{ids.length}个人，只要他们加入游戏，你就可以获得奖励哦^_^ 谢谢你的支持"})
		else
			@isappuser = User.find(:all,
									:conditions => [" xid in (?) and session_key is not null ",@current_user.friend_ids]
									)
			@notapparray = @current_user.friend_ids
			@notapparray_five = []
			@isapparray = []
			@isappuser.each do |no|
				@isapparray << no.xid
				@notapparray.delete(no.xid)
			end
			pp("------------------------@notapparray:#{@notapparray.inspect}-----------")
			(1..5).each do |i|
				  @notapparray_five << @notapparray.rand
			 end 
		 end
	end
	
	
	def rob
	    
		
		@user = User.find(params[:id])
		
		     
			 if (usership=params[:usership]) == nil
				 xn_redirect_to("home/friend/#{@user.xid}",{:notice => "抢劫前请选择一只空闲的船，如果你没有空闲的船，<a href=\"#{url_for  :controller => :shop,:action => :index}\">去买一艘吧？</a>"})
			 else
				 @usership = Usership.find(usership[:id])
				 if false # @usership.robof != nil and @usership.robof !=0
					 #xn_redirect_to("home/friend/#{@user.xid}",{:notice => "抢劫前请选择一只空闲的船，如果你没有空闲的船，<a href=\"#{url_for  :controller => :shop,:action => :index}\">去买一艘吧？</a>"})
				 else
					 
					 dock = params[:dock]
					 #pp("-------------usership:#{@usership.inspect}------------")
					 
					 
					 #重新开始抢劫
					 case dock
						when "抢劫码头1"
						   if (@user.dock1 == nil or @user.dock1 == 0 ) and ! isrobself
						         rob_balance(@usership)
								 @user.dock1 = usership[:id]
								 @user.dock1_time = Time.now
								 @user.save
								
								 @usership.robof = @user.xid
								 @usership.save
						   end
						when "抢劫码头2"
						   if (@user.dock2 == nil or @user.dock2 == 0 ) and ! isrobself
						         rob_balance(@usership)
								 @user.dock2 = usership[:id]
								 @user.dock2_time = Time.now
								 @user.save
								
								 @usership.robof = @user.xid
								 @usership.save
						   end
						when "抢劫码头3"
						   if (@user.dock3 == nil or @user.dock3 == 0 ) and ! isrobself
						         rob_balance(@usership)
								 @user.dock3 = usership[:id]
								 @user.dock3_time = Time.now
								 @user.save
								
								 @usership.robof = @user.xid
								 @usership.save
						   end
						when "停靠"
						   if (@user.dock4 == nil or @user.dock4 == 0 ) and ! isrobself
						         balance(@usership)
								 @user.dock4 = usership[:id]
								 @user.dock4_time = Time.now
								 @user.save
								
								 @usership.robof = @user.xid
								 @usership.save
						   end
						when "夺回码头1"
						   if @user.dock1  and @user.dock1 > 0  and  isrobself 
						         reseize_balance(Usership.find(@user.dock1))
						   
						   end
						when "夺回码头2"
						   if @user.dock2  and @user.dock2 > 0  and  isrobself 
						         reseize_balance(Usership.find(@user.dock2))
						   
						   end
						when "夺回码头3"
						   if @user.dock3  and @user.dock3 > 0  and  isrobself 
						         reseize_balance(Usership.find(@user.dock3))
						   
						   end
						when "赶跑TA"
						   if @user.dock4  and @user.dock4 > 0  and  isrobself 
						         balance(Usership.find(@user.dock4))
						   
						   end
				     end
				 xn_redirect_to("home/friend/#{@user.xid}")
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
				# xn_redirect_to("home/friend",{:notice => "不能抢劫自己"})
	
	end
end
