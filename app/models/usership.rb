# == Schema Information
# Schema version: 20080907155019
#
# Table name: userships
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  attack     :integer
#  capacity   :integer
#  robspeed   :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Usership < ActiveRecord::Base
require "pp"
serialize :sids
belongs_to :user

def ship
	@ship ||= Ship.find(:all, :conditions => [" id = ? ", self.ship_id]).first
end
def robuser
	@robuser ||= User.find(:all, :conditions => [" xid = ? ", self.robof]).first
end

def robdock=(robof)
		case self.id
			 when robuser.dock1
				  robuser.dock1 = robof
			 when robuser.dock2
				  robuser.dock2 = robof
			 when robuser.dock3
				  robuser.dock3 = robof
			 when robuser.dock4
				  robuser.dock4 = robof
		end
end

def robdock
    if !@robdock
		case self.id
			 when robuser.dock1
				  @robdock = robuser.dock1
			 when robuser.dock2
				  @robdock = robuser.dock2
			 when robuser.dock3
				  @robdock = robuser.dock3
			 when robuser.dock4
				  @robdock = robuser.dock4
		end
	end 
	@robdock 
end 



def robtime
    if !@robtime
		case self.id
			 when robuser.dock1
				  @robtime = robuser.dock1_time
			 when robuser.dock2
				  @robtime = robuser.dock2_time
			 when robuser.dock3
				  @robtime = robuser.dock3_time
			 when robuser.dock4
				  #@robtime = robuser.dock4_time
				  @robtime = nil
		end
	end 
	@robtime 
end 
#@robrock = @user.r
end
