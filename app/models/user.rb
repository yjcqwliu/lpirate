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
    
	has_many :usership,:order => 'updated_at desc ' 
	
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
			user.business_count = 0 if user.business_count.nil? || (Time.now.utc + 8.hour).to_i / 86400 > (user.business_update_at + 8.hour).to_i / 86400
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
				user.captain_lattribute = 1 
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
	   self.captain_sell_count = 0 if captain_sell_updated_at.nil? || (Time.now.utc + 8.hour).to_i / 86400 > (captain_sell_updated_at + 8.hour).to_i / 86400
	   save
	   if self.captain_sell_count.to_i >= 3 
	       resault = "TA今天雇佣次数已满，每个船长每天最多只能被雇佣三次，明天再来TA吧"
	   else
	       if current_user.gold < captain_price 
			   resault = "你的金币不够"
		   else
		       
			   if  current_user.mycaptain.length >= current_user.usership.length 
			       resault = "你已经不能再雇佣更多的船长了，你每多拥有一艘船可以多雇佣一个船长"
			   else
			       begin
					   if captain_master != xid
						   master_user = User.login(captain_master)
						   master_user.gold += captain_price
						   master_user.save
					   end
					   self.captain_usership_id = 0					   
					   del_att_to_usership
					   current_user.gold -= captain_price
					   current_user.save
					   self.captain_price = up_sell_price
					   self.captain_master = current_user.xid
					   self.captain_sell_updated_at = Time.now.utc
					   self.captain_sell_count += 1
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
		   del_att_to_usership
	       self.captain_master = xid
		   self.captain_usership_id = 0
		   self.save
		   notice = "解雇成功"
		end	
	end
	def mycaptain
	    @mycaptain = User.find(:all,:conditions => [" captain_master = ? ",xid])
	end
	def captain_ship
		   if @captain_ship 
		       @captain_ship
		   else
		       if captain_usership_id != 0
				   cap_sh_tmp = Usership.find(:all,:conditions => [" id = ?",captain_usership_id])
				   if cap_sh_tmp.length == 1
				       cap_sh_tmp.first
				   else
				       self.captain_usership_id = 0
				       self.save
					   nil
				   end
			   else
			       nil
			   end 
		   end
	end
	def appoint_ship(current_user,usership_id)
    	if captain_master != current_user.xid 
	       notice = "你没有权限给TA分配船只，TA不是你的雇佣船长"
		else
		   #pp("*******self.captain_usership_id#{captain_usership_id}*******usership_id:#{usership_id}****")
		   if captain_usership_id.to_i != usership_id.to_i
			   #pp("*******current_user#{current_user.inspect}*******usership_id:#{captain_usership_id}****")
			   User.distroy_appoint_ship(current_user,captain_usership_id)
			   self.captain_usership_id = usership_id
			   #pp("*******self.captain_usership_id#{self.captain_usership_id}***********")
			   save
			   add_att_to_usership
		   end
		   notice = "分配船长成功"
		end
	end
	def self.distroy_appoint_ship(current_user,usership_id)
	    if usership_id != 0
			user = User.find(:all,:conditions => [" captain_usership_id = ? ",usership_id])
			#pp("------user:#{user.inspect}---------")
			if user.length >0
				user = user.first
				if user.captain_master != current_user.xid 
				   notice = "你没有权限给TA分配船只，TA不是你的雇佣船长"
				else
				   #pp("------user:#{user.inspect}---------")
				   user.del_att_to_usership
				   user.captain_usership_id = 0
				   user.save
				end
			end
		end
	end
	
	def add_exp(current_user,lgold)
	    lexp = lgold / 100
	    if captain_master != current_user.xid 
		    notice = "你不是TA的船长，经验无法获得"
		else
		    self.captain_exp += lexp
			while self.captain_exp >= self.captain_aexp 
			    self.captain_exp -= self.captain_aexp
				self.captain_lattribute += 1 
				self.captain_level += 1
				self.captain_aexp = (1.5 **(self.captain_level-1)) * 10 
			end 
			save
		end
		notice
	end
	def self.find_by_xid(t_xid)
	    t_u = User.find(:all,:conditions => [" xid = ?",t_xid.to_s])
		if t_u.length == 1
		   t_u.first
		else
		   nil
		end
	end
	
	def add_capacity(current_user)
	    if captain_master != current_user.xid 
		    notice = "你不是TA的船长，无法给TA分配属性"
		else
	        if captain_lattribute > 0
			    del_att_to_usership
			    self.captain_lattribute -= 1
			    self.captain_capacity += 1
				save
				
				add_att_to_usership
				notice = "成功分配了一点属性到“货舱容量”上"
			else
			    notice = "你没有足够的剩余属性点"
			end
		end
		notice
	end
	
	def add_robspeed(current_user)
	    if captain_master != current_user.xid 
		    notice = "你不是TA的船长，无法给TA分配属性"
		else
	        if captain_lattribute > 0
			    del_att_to_usership
			    self.captain_lattribute -= 1
			    self.captain_robspeed += 1
				save
				add_att_to_usership				
				notice = "成功分配了一点属性到“抢劫速度”上"
			else
			    notice = "你没有足够的剩余属性点"
			end
		end
		notice
	end
	
	def add_attack(current_user)
	   if captain_master != current_user.xid 
		    notice = "你不是TA的船长，无法给TA分配属性"
		else
	        if captain_lattribute > 0
			    del_att_to_usership
			    self.captain_lattribute -= 1
			    self.captain_attack += 1
				save				
				add_att_to_usership
				notice = "成功分配了一点属性到“攻击”上"
			else
			    notice = "你没有足够的剩余属性点"
			end
		end
		notice
	end
	def add_att_to_usership
	    if captain_usership_id != 0
			tmp_usership = Usership.find(captain_usership_id)
			tmp_usership.capacity = tmp_usership.capacity + ( captain_capacity * 100 )
			tmp_usership.robspeed = tmp_usership.robspeed + ( captain_robspeed * 50 )
			tmp_usership.attack = tmp_usership.attack + ( captain_attack * 2 )
			tmp_usership.save
			pp("---------------tmp_usership.capacity:#{tmp_usership.capacity}---------------")
		end 
	end
	def del_att_to_usership
	    if captain_usership_id != 0
			tmp_usership = Usership.find(captain_usership_id)
			tmp_usership.capacity = tmp_usership.capacity - ( captain_capacity * 100 )
			tmp_usership.robspeed = tmp_usership.robspeed - ( captain_robspeed * 50 )
			tmp_usership.attack = tmp_usership.attack - ( captain_attack * 2 )
			tmp_usership.save
		end
	end
	def buy_back
	    if captain_master != xid
		    if gold >= captain_price
			    self.gold -= self.captain_price
			    self.del_att_to_usership
				self.captain_master = self.xid
				self.captain_usership_id = 0
				save
				notice ="你成功的把自己赎回来了"
			else
			    notice = "你没有足够的金币赎身"
			end
		else
		    notice = "你是自己的雇主，无法再赎身"
		end
		
	end
private
    def up_sell_price
	    @sell_price = captain_price * 1.31 + 323
	end
	
	
end
