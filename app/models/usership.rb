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
end
