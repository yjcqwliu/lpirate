class NoticeController < ApplicationController
	def all
	    limit_friend_ids = []
	    u=User.find(:all,
				  :conditions => [" xid in (?) ",@current_user.friend_ids],
				  :order => " updated_at desc ",
				  :limit => 10
				  )
	    u.each do |u|
		limit_friend_ids << u.xid 
		end
	
	#@current_user.friend_ids,
	   @mynotice = Notice.find(:all,
								 :conditions => [" ltype <> 11 and ( from_xid in (?,?) or to_xid in (?,?) )",limit_friend_ids,@current_user.xid.to_s,limit_friend_ids,@current_user.xid.to_s],
								  :order => " updated_at desc ",
								  :limit => 30
								 )
		
		render :action => :index
	end
	
	def index
		@mynotice = Notice.find(:all,
								 :conditions => ["ltype <> 11 and ( from_xid = ? or to_xid = ? ) ",@current_user.xid.to_s,@current_user.xid.to_s],
								  :order => " updated_at desc ",
								  :limit => 30
								 )
		
		render :action => :index
	end
	
	def business
		@mynotice = Notice.find(:all,
								 :conditions => [" ltype =11 and ( from_xid = ? or to_xid = ? )",@current_user.xid.to_s,@current_user.xid.to_s],
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
	
	def ltest
        limit_friend_ids = []
	    User.find(:all,
				  :conditions => [" xid in (?)",@current_user.friend_ids],
				  :limit => 3,
				  :order => " updated_at desc "
				  ).each do |u|
		limit_friend_ids << u.xid 
		end
	
	#@current_user.friend_ids,
	   @mynotice = Notice.find(:all,
								 #:conditions => ["( from_xid in (?,?) or to_xid in (?,?) ) and ltype=11",limit_friend_ids,@current_user.xid.to_s,limit_friend_ids,@current_user.xid.to_s],
								 # :order => " updated_at desc ",
								  :limit => 30
								 )
		
		render :action => :index
	end
	
end
