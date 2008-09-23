# == Schema Information
# Schema version: 20080907155019
#
# Table name: messages
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  content    :text
#  user_id    :integer
#  from_id    :integer
#  from_xid   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Message < ActiveRecord::Base
end
