class FriendController < ApplicationController
	def index
	
	end 
	
	def list
	#���º�������
	if @current_user.friend_ids.nil? or @current_user.friend_ids.size == 0 or @current_user.updated_at > (Time.now - 48.hour)
        res = xiaonei_session.invoke_method("xiaonei.friends.get")
        if res.kind_of? Xiaonei::Error
          @current_user.friend_ids = [] if @current_user.friend_ids.empty?
        else
          @current_user.friend_ids = res
        end
        @current_user.save
	 end 
	#�г���������
	
	render:layout => false
	end
end
