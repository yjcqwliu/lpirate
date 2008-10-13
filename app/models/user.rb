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
	    user = User.find(:all,
		                  :conditions => [" xid= ? ",u_id.to_s]
						  )
		if ! user or user.length == 0 then
		     user = User.first_login(u_id)
		else
		     user=user.first
		end
		#��������ֶ�
		if invite != 0  && user.invite != 0
			invite_array = user.invite || []
			if !invite_array.include?(invite)			
			invite_array.push(invite)
			end
			user.invite_will_change!
			user.invite = invite_array
			user.save
		end
		
		user
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
end
