class NoticeController < ApplicationController
	def all
		@mynotice = Notice.find(:all,
								 :conditions => ["( from_xid in (?,?) or to_xid in (?,?) ) and ltype <> 11",@current_user.friend_ids,@current_user.xid.to_s,@current_user.friend_ids,@current_user.xid.to_s],
								  :order => " updated_at desc ",
								  :limit => 30
								 )
		
		render :action => :index
	end
	
	def index
		@mynotice = Notice.find(:all,
								 :conditions => ["( from_xid = ? or to_xid = ? ) and ltype <> 11",@current_user.xid.to_s,@current_user.xid.to_s],
								  :order => " updated_at desc ",
								  :limit => 30
								 )
		
		render :action => :index
	end
	
	def business
		@mynotice = Notice.find(:all,
								 :conditions => ["( from_xid = ? or to_xid = ? ) and ltype = 11",@current_user.xid.to_s,@current_user.xid.to_s],
								  :order => " updated_at desc ",
								  :limit => 30
								 )
		
		render :action => :index
	end
end
