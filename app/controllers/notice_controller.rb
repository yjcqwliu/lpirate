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
	
	def myall
	   @page = params[:page] || 1
	   @mynotice = Notice.find(:all,
								 :conditions => [" from_xid = ? and ltype = ? ",params[:from_xid] || 0,params[:ltype] || 0 ],
								  :order => " updated_at desc "
								 )
	   @mynotice = @mynotice.paginate(:page => @page, :per_page => 100)
	end
end
