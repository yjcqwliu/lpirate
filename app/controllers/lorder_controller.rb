class LorderController < ApplicationController
def index
    @page = params[:page] || 1
	@user = User.find(:all,
	                  :conditions => [" xid in (?,?) and session_key is not null ",@current_user.friend_ids,@current_user.xid.to_s],
					  :order => " gold desc ",
					  :limit => 200
					  )
	@user = @user.paginate(:page => @page, :per_page => 20)
	
end

def friendship

end

def allgold
    @page = params[:page] || 1
	@user = User.find(:all,
	                  :conditions => [" session_key is not null ",@current_user.xid.to_s],
					  :order => " gold desc ",
					  :limit => 500
					  )
	@user = @user.paginate(:page => @page, :per_page => 20)
	render :action => :index

end 

def allship

end
end
