class ShopController < ApplicationController
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
			@current_user.save
			xn_redirect_to("shop/index",{"notice" => "购买成功"})
		else
		    xn_redirect_to("shop/index",{"notice" => "金币不足"})
		end   
	 end 
  end
end
