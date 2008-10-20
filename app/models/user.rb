# == Schema Information
# Schema version: 20080907155019
#
# Table name: users
#
#  id          :integer         not null, primary key
#  xid         :integer
#  friend_ids  :text
#  gold        :integer
#  pgold       :integer
#  bship_ftime :date
#  created_at  :datetime
#  updated_at  :datetime
#

class User < ActiveRecord::Base
    serialize :friend_ids
	serialize :invite
	
    has_many :usership
	has_many :notice
	
	
	
    def self.login(u_id,invite = 0)
			if u_id 
			user = User.find(:all,
							  :conditions => [" xid= ? ",u_id.to_s]
							  )
			if ! user or user.length == 0 then
				 user = User.first_login(u_id)
			else
				 user=user.first
			end
			
	
			#添加邀请字段
			if invite != 0  && user.invite != 0
				invite_array = user.invite || []
				if !invite_array.include?(invite)			
				invite_array.push(invite)
				end
				user.invite_will_change!
				user.invite = invite_array
				user.save
			end
			###############贸易相关数据初始化#################
			user.business_update_at = Time.now.utc if user.business_update_at.nil?
			user.business_top = 20 if user.business_top.nil?
			user.business_count = 0 if (user.business_count.nil? and user.business_update_at.nil?) || (Time.now.utc + 8.hour).to_i / 86400 > (user.business_update_at + 8.hour).to_i / 86400
			##############船长买卖相关数据初始化##############
			if user.captain_level.nil?
				user.captain_level =1 
				user.captain_master = user.xid 
				user.captain_exp = 0 
				user.captain_aexp = 10 
				user.captain_price = 1000 
				user.captain_capacity = 0 
				user.captain_robspeed = 0 
				user.captain_attack = 0 
				user.captain_lattribute = 0 
				user.captain_usership_id = 0 
				user.captain_sell_count = 0 
			end
			user
		else
		    nil
		end
		
	end 
	
	def self.first_login(u_id,invite_id=0)
	    user = User.new
		user.xid = u_id
		user.gold = 500 
		user.pgold = 0
		user.save
		user.addship(1)
		user
	end 
	
	def addship(ship_id)
	    @newship=self.usership.new
		@ship=Ship.find(ship_id)
       	@newship.name=@ship.name
		@newship.ship_id=ship_id
		@newship.attack=@ship.attack
		@newship.capacity=@ship.capacity
		@newship.robspeed=@ship.robspeed
		@newship.save
	end
	def xn_session
		@xn_session ||= Xiaonei::Session.new("xn_sig_session_key" => session_key, "xn_sig_user" => xid)
	end
    
	def captain_buy(current_user)
	   captain_sell_count = 0 if captain_sell_updated_at.nil? || (Time.now.utc + 8.hour).to_i / 86400 > (captain_sell_updated_at + 8.hour).to_i / 86400
	   if captain_sell_count == 3 
	       resault = "今天雇佣次数已满，每个船长每天最多只能被雇佣三次"
	   else
	       
		   if current_user.gold < captain_price 
			   resault = "你的金币不够"
		   else
		       
			   if  current_user.mycaptain.length >= current_user.usership.length 
			       resault = "你已经不能再雇佣更多的船长了，你每多拥有一艘船可以多雇佣一个船长"
			   else
			       begin
					   if captain_master != "0"
						   master_user = User.login(captain_master)
						   master_user.gold += captain_price
						   master_user.save
					   end
					   current_user.gold -= captain_price
					   current_user.save
					   self.captain_price = up_sell_price
					   self.captain_master = current_user.xid
					   self.captain_sell_updated_at = Time.now.utc
					   save
			       end
			       resault = "雇佣成功"
			   end
		   end 	   
	        
	   end
	   resault
	end
    
	def captain_disbuy(current_user)
	    if current_user.xid != captain_master or xid == current_user.xid
		   notice = "对不起，你不是TA的雇主"
		else
	       self.captain_master = xid
		   self.captain_sell_updated_at = Time.now.utc
		   self.save
		   notice = "解雇成功"
		end	
	end
	def mycaptain
	    @mycaptain = User.find(:all,:conditions => [" captain_master = ? ",xid])
	end
private
    def up_sell_price
	    @sell_price = captain_price * 1.21 + 323
	end
	
end
