# == Schema Information
# Schema version: 20080907155019
#
# Table name: userassignments
#
#  id            :integer         not null, primary key
#  assignment_id :integer
#  user_id       :integer
#  state         :boolean
#  created_at    :datetime
#  updated_at    :datetime
#

class Userassignment < ActiveRecord::Base
end
