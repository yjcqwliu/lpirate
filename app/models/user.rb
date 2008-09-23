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
    has_many :usership
	
	
    def self.login(u_id)
	    user = User.find(:all,
		                  :conditions => [" xid= ? ",u_id]
						  )
		if ! user or user.length == 0 then
		     user = User.first_login(u_id)
		else
		     user=user.first
		end
		user
	end 
	
	def self.first_login(u_id)
	    user = User.new
		user.xid = u_id
		user.gold = 500 
		user.pgold = 0
		user.save
		@newship=user.usership.new
		@ship=Ship.find(1)
		@newship.ship_id=1
		@newship.name=@ship.name
		@newship.attack=@ship.attack
		@newship.capacity=@ship.capacity
		@newship.robspeed=@ship.robspeed
		@newship.save
		user
	end 
end
