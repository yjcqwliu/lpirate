class BusinessController < ApplicationController
	def business
	    if id = params[:id] 
		    @user = User.find(id)
			if canbusiness
			    @current_user.business_count = 0 if @current_user.business_count.nil?
				@current_user.business_exp = 0 if @current_user.business_exp.nil?
			    @current_user.business_count += 1
				add_business_exp(1)
				getgold = add_gold
				@current_user.gold += getgold
									
				@current_user.business_update_at = Time.now.utc if Time.now.utc > @current_user.business_update_at 
				#pp("--------save---business_update_time:#{@current_user.business_update_at}-----Time.now:#{Time.now + 8.hour}--------")
				@current_user.save
				#pp("--------save2---business_update_time:#{@current_user.business_update_at}-----Time.now:#{Time.now + 8.hour}--------")
				#################新鲜事##############################
				@notice = "成功与#{url_to_island(@user.xid)}交易，赚了#{getgold}金币"
				notice = Notice.new()
				notice.user_id = @current_user.id
				notice.from_xid = @current_user.xid
				notice.to_xid = @user.xid
				notice.content = "#{url_to_island(@current_user.xid)}开着TA的商船与#{url_to_island(@user.xid)}进行友好贸易，赚了#{getgold}金币"
				notice.ltype = 11
				notice.save
				####################end############################
		    else
			    @notice = "已经达到了今天的贸易限额"
			end
		end	
		xn_redirect_to("home/friend",{"notice" => @notice})
	end
	
	def invite 
	     ids = params[:ids]
		
	     if ids and ids.length >0
		    ids = ids.first
		    @user = User.find(:all,
			                  :conditions => [" xid = ? ",ids.to_s]
							  )
			if @user && @user.length >0 
			    @user = @user.first
			
				if canbusiness
					@current_user.business_count = 0 if @current_user.business_count.nil?
					@current_user.business_exp = 0 if @current_user.business_exp.nil?
					@current_user.business_count += 1
					add_business_exp(2)
					getgold = add_gold * 2
					@current_user.gold += getgold
					
					@current_user.business_update_at = Time.now.utc if Time.now.utc > @current_user.business_update_at #pp("--------save---business_update_time:#{@current_user.business_update_at}-----Time.now:#{Time.now.strftime('%Y/%m/%d')}--------")
					@current_user.save
					#pp("--------save2---business_update_time:#{@current_user.business_update_at}-----Time.now:#{Time.now.strftime('%Y/%m/%d')}--------")
					#################新鲜事##############################
					@notice = "成功向#{url_to_island(@user.xid)}倒卖大量商品，赚得#{getgold}金币"
					notice = Notice.new()
					notice.user_id = @current_user.id
					notice.from_xid = @current_user.xid
					notice.to_xid = @user.xid
					notice.content = "#{url_to_island(@current_user.xid)}开着TA的商船向#{url_to_island(@user.xid)}倒卖了大量商品，赚了#{getgold}金币"
					notice.ltype = 11
					notice.save
					####################end############################
				else
					@notice = "已经达到了今天的贸易限额"
				end
			end
		end	
		xn_redirect_to("home/friend/",{"notice" => @notice})
	end
private
    def canbusiness
	    if @current_user.business_count >= @current_user.business_top
		    false
		else
		    true
		end
	end
	def add_business_exp(exp = 1)
	    @current_user.business_exp = 0 if @current_user.business_exp.nil?
	    @current_user.business_exp += exp
	end
	def add_gold
	    100 + rand(100)
	end
end
