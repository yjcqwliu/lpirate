class ShopController < ApplicationController
  require 'pp'
  def index
    @notice = params[:notice]
    @ships = Ship.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ships }
    end
  end
  
  def buy
     if id = params[:id] then
	    @ship = Ship.find(id)
	    if @current_user.gold >= @ship.price then
		    @current_user.addship(id)
			@current_user.gold -= @ship.price
			@current_user.friend_ids_will_change!
			@current_user.save
			xn_redirect_to("shop/index",{"notice" => "购买成功，<a href=\"#{url_for :controller => :home,:action => :myship}\">快去你的码头看看新船吧</a>"})
		else
		    xn_redirect_to("shop/index",{"notice" => "金币不足"})
		end   
	 end 
  end
  def sell
		@usership_id = params[:id]
		#pp "-----ismyship(usership_id):#{ismyship(usership_id)}----"
		if @current_user.usership.length ==1 
		    xn_redirect_to("home/myship",{:notice=>"你不能卖掉你的最后一艘船"})
		else
			if params[:act] != "confirm"
				@usership = Usership.find(@usership_id)
			else
				if ismyship(@usership_id) 
					gain = sellship(@usership_id)
					xn_redirect_to("home/myship",{:notice=>"你成功卖掉了船，赚得#{gain}个金币"})
				else
					xn_redirect_to("home/myship",{:notice=>"你不能卖掉别人的船"})
				end
			end
		end
  end
private
  def ismyship(usership_id)
      flag = false
      @current_user.usership.each do |ship|
	  #pp "-----usership_id:#{usership_id},ship.id:#{ship.id}------"
	       if usership_id.to_i == (ship.id).to_i
		       flag = true
			   break
		   end
	  end
	  flag
  end
  def sellship(usership_id)
      usership = Usership.find(@usership_id)
      price = usership.ship.price * 0.5
	  @current_user.gold += price
	  @current_user.friend_ids_will_change!
	  @current_user.save
	  rob_balance(usership)   #买出船之前结算
	  usership.destroy
	  price
  end
end
