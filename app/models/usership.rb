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
pp("=======ship_id:#{self.ship_id}============")
@ship ||= Ship.find(:all, :conditions => [" id = ? ", self.ship_id])
@ship=@ship.first
end
end
