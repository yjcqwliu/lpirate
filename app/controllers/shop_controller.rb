class ShopController < ApplicationController
  def index
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
		end   
	 xn_redirect_to("shop/index",{"notice" => "¹ºÂò³É¹¦"})
	 end 
  end
end
