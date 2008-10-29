class CaptainController < ApplicationController

	def index
	    @captain_user = @current_user.mycaptain
		if uid = params[:id]
			@now_user = User.login(uid)
		else
			@now_user = @current_user
		end 
		@captain_notice = Notice.find(:all,:conditions => ["( to_xid = ? or from_xid = ? ) and (ltype =12 or ltype =13)",@current_user.xid.to_s,@current_user.xid.to_s],:limit => 10,:order => " updated_at desc ")
		pp "-----------@captain_notice:#{@captain_notice.inspect}---------"
	end
	
	def buy
	    if uid = params[:id]
		    @user = User.login(uid)
			if @user.xid == @current_user.xid  && @user.captain_master == @current_user.xid 
			    notice = "TA已经是你的雇佣船长了"
			else
			    notice = @user.captain_buy(@current_user)
			end
			xn_redirect_to("captain/show/#{uid}",{"notice" => notice})
		end
	end
	
	def disbuy
	    if uid = params[:id]
		    @user = User.login(uid)
			notice = @user.captain_disbuy(@current_user)
			xn_redirect_to("captain/show/#{uid}",{"notice" => notice})
		end
	end
	
	def show
	   if (uid = params[:id]  || params[:ids].to_s) != ""
		    @user = User.login(uid)
		else
		    @user = User.login(@current_user.friend_ids.rand)
		end
	end
	
	def friendlist
		@friend_list = params[:ids] || []
		if @friend_list.length == 0 
		     12.times {
					f = @current_user.friend_ids.rand
					@friend_list << f if !@friend_list.include?(f)
				}
		end
		pp ("-------------@friend_list:#{@friend_list.inspect}--------")
		#@friend = User.find(:all,
		#                    :conditions => [" xid in (?) ",friend_list]
	    #					    )
		#@page = params[:page] || 1
		#@friend = @friend.paginate(:page => @page, :per_page => 30)
    end
	
	def appoint
	    usership = params[:usership] 
	    captain = User.find(usership[:captain])
		notice =captain.appoint_ship(@current_user,usership[:id])
		xn_redirect_to("captain/index",{"notice" => notice})
	end
	
	def add_capacity
	    id = params[:id]
	    notice = User.find_by_xid(id).add_capacity(@current_user)
		xn_redirect_to("captain/index/#{id}",{"notice" => notice})
	end
	
	def add_robspeed
	    id = params[:id]
	    notice = User.find_by_xid(id).add_robspeed(@current_user)
		xn_redirect_to("captain/index/#{id}",{"notice" => notice})
	end
	
	def add_attack
	   id = params[:id]
	   notice = User.find_by_xid(id).add_attack(@current_user)
	   xn_redirect_to("captain/index/#{id}",{"notice" => notice})
	end
	
	def buy_back
	   notice = @current_user.buy_back
	   xn_redirect_to("captain/index",{"notice" => notice})
	end
end
