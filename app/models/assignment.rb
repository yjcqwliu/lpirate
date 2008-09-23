# == Schema Information
# Schema version: 20080907155019
#
# Table name: assignments
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#

class Assignment < ActiveRecord::Base
end
