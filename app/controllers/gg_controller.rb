class GgController < ApplicationController
def callback
	adapikey = "3276974334c9e8c75543badeae2fbd59"
	money = params[:money]
	uid = params[:uid]
	orderid = params[:orderid]
	sign = params[:sign]
	pp "-------------sign:#{sign}--money:#{money}--uid:#{uid}--orderid:#{orderid}--"
	pp "-------------- Digest::MD5.hexdigest(money+uid+orderid+adapikey)#{ Digest::MD5.hexdigest(money+uid+orderid+adapikey)}---------"
	if sign == Digest::MD5.hexdigest(money + uid + orderid + adapikey)
	    user = User.find_by_xid(uid)
		if user
			user.pgold += money.to_i
			user.save
			render :text => "success"
		else
		    render :text => "can't find the user"
		end
	else
	    render :text => "error"
	end
end
def index

end
end
