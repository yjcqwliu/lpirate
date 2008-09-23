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
    def self.login(u_id)
	    user = User.find(u_id)
		if ! user then
		     user = User.first_login(u_id)
		end
		user
	end 
	
	def self.first_login(u_id)
	    user = User.new
		user.xid = u_id
		user.gold = 500 
		user.save
		user
	end 
end
