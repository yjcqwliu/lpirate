class FriendController < ApplicationController
	before_filter :set_current_user
	def index
	
	end 
	
	def list
		#更新好友数据
		render :layout => false
	end
end
