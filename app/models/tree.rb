# == Schema Information
# Schema version: 20080907155019
#
# Table name: trees
#
#  id           :integer         not null, primary key
#  state        :integer
#  user_id      :integer
#  level        :integer
#  produce_time :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

class Tree < ActiveRecord::Base
end
