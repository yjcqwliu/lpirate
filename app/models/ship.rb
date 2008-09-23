# == Schema Information
# Schema version: 20080907155019
#
# Table name: ships
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  attack     :integer
#  capacity   :integer
#  robspeed   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Ship < ActiveRecord::Base
end
