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
belongs_to :ship
has_one :captain,
		:class_name => "User",
		:foreign_key => "captain_usership_id"
def robuser
	@robuser ||= User.find(:first,:conditions => [" xid = ? ",robof.to_s])
end

def robdock=(robof)
    if robuser
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
end

def robdock
    if !@robdock and robuser
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
    if !@robtime and robuser
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
