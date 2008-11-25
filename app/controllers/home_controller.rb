class HomeController < ApplicationController
	def index
		@user = @current_user
	    limit_friend_ids = []
	    u=User.find(:all,
				  :conditions => [" xid in (?) ",@current_user.friend_ids],
				  :order => " updated_at desc ",
				  :limit => 3
				  )
	    u.each do |u|
		limit_friend_ids << u.xid 
		end
	
	#@current_user.friend_ids,
	   @mynotice = Notice.find(:all,
								 :conditions => [" (ltype < 11 or ltype >12) and ( from_xid in (?,?) or to_xid in (?,?) )",limit_friend_ids,@current_user.xid.to_s,limit_friend_ids,@current_user.xid.to_s],
								  :order => " updated_at desc ",
								  :limit => 30
								 )
	end
	
	def friend
	   if id = params[:id]
		    @user  = User.login(id)
		else
		    @user  = User.login(@current_user.friend_ids.rand)
		end	   
		@mynotice = nil
	   render :action => :index
	end
	
	def myship
	   
	end
	def change_ship_name
	    if id = params[:id] 
		     @usership = Usership.find(id)
		end
	end
	def save_change_ship_name
	    if id = params[:ship_id] 
		    @usership = Usership.find(id)
			if @usership.user.xid == @current_user.xid
				 if @current_user.pgold > 0 
					 if ship_name = params[:ship_name]
						  ship_name += "号"
						  #pp "------------ship_name:#{ship_name.length}-------------"
						  begin
							  @current_user.pgold -= 1
							  @current_user.save
							  @usership.name = ship_name
							  @usership.save
							  Bmorder.create(:uid => @current_user.xid, :money => -1, :orderid => -1, :info => "修改船只名称")
						  end
						  @notice = "船只名称修改成功"
					 else
						  @notice = "请输入需要修改的船只名称"
					 end
				 else
					 @notice = "对不起，您的海盗币不够"
				 end
			else
				 @notice = "对不起，你没有权限修改别人的船只"
			end
		end
		xn_redirect_to("home/change_ship_name/#{id}",{:notice => @notice})
	end
	def help
	    @friend = current_user.friend_ids.rand
	end
	
	def invite
	    if ids=params[:ids]
			ids.each do |id|
				User.login(id,@current_user.xid)
			end
			 xn_redirect_to("home/invite#ad",{"notice" => "成功邀请了#{ids.length}个人，只要他们加入游戏，你就可以获得奖励哦^_^ 谢谢你的支持"})
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
			#pp("------------------------@notapparray:#{@notapparray.inspect}-----------")
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
								 @user.friend_ids_will_change!
								 @user.save
								
								 @usership.robof = @user.xid
								 @usership.save
						   end
						when "抢劫码头2"
						   if (@user.dock2 == nil or @user.dock2 == 0 ) and ! isrobself
						         rob_balance(@usership)
								 @user.dock2 = usership[:id]
								 @user.dock2_time = Time.now
								 @user.friend_ids_will_change!
								 @user.save
								
								 @usership.robof = @user.xid
								 @usership.save
						   end
						when "抢劫码头3"
						   if (@user.dock3 == nil or @user.dock3 == 0 ) and ! isrobself
						         rob_balance(@usership)
								 @user.dock3 = usership[:id]
								 @user.dock3_time = Time.now
								 @user.friend_ids_will_change!
								 @user.save
								
								 @usership.robof = @user.xid
								 @usership.save
						   end
						when "停靠"
						   if (@user.dock4 == nil or @user.dock4 == 0 ) and ! isrobself
						         balance(@usership)
								 @user.dock4 = usership[:id]
								 @user.dock4_time = Time.now
								 @user.friend_ids_will_change!
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
				 xn_redirect_to("home/friend/#{@user.xid}#nav")
				 end 
				
			 end
		 
	end
	
	def back_home
	    u_ship = Usership.find(params[:id])
		if u_ship.user_id == @current_user.id
			l_gold = rob_balance(u_ship)
		end
		xn_redirect_to("home/index#myship",{"notice" => "成功返航，抢劫了#{l_gold}金币"})
	end
	def tongji
		if params[:help] == '5'
			tem_friend_ids = @current_user.friend_ids
				p "---------use friend api"
					res = xiaonei_session.invoke_method("xiaonei.friends.get")
					if res.kind_of? Xiaonei::Error
					  @current_user.friend_ids = [] if @current_user.friend_ids.empty?
					else
					  @current_user.friend_ids = res
					end
					@current_user.friend_ids_will_change!
					@current_user.save
		else
			p "------------didn't use friend api"
		end
		render :layout => false
	end
	def css5
	    render :layout => false
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
