class FriendController < ApplicationController
	before_filter :set_current_user
	def index
	
	end 
	
	def list
		#���º�������
		render :layout => false
	end
end
