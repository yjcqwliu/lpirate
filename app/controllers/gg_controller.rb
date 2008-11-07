class GgController < ApplicationController
def callback
	adapikey = "3276974334c9e8c75543badeae2fbd59"
	money = params[:money]
	uid = params[:uid]
	orderid = params[:orderid]
	sign = params[:sign]
	#pp "-------------sign:#{sign}--money:#{money}--uid:#{uid}--orderid:#{orderid}--"
	#pp "-------------- Digest::MD5.hexdigest(money+uid+orderid+adapikey)#{ Digest::MD5.hexdigest(money+uid+orderid+adapikey)}---------"
	if sign == Digest::MD5.hexdigest(money + uid + orderid + adapikey)  #运算MD5判断订单数据是否合法
	    if Bmorder.find(:all, :conditions => [" orderid = ? ",orderid]).blank?
		    user = User.find_by_xid(uid) #在user表中通过校内ID寻找记录
			if user
			    begin
					user.pgold += money.to_i
					user.save
					Bmorder.create(:uid => uid, :money => money, :orderid => orderid, :sign => sign, :info => "通过“赚取海盗币”")
				rescue Exception => exp
					#puts "exp: #{exp.inspect}"
				end
				#render :text => "success"
			else
				#render :text => "can't find the user"
			end
		else
		    #render :text => "the order already done "
		end
	else
	    #render :text => "error sign"
	end
end
def index

end
def my
    @page = params[:page] || 1
	@bmorder = Bmorder.find(:all,
						  :conditions => [" uid = ? ",@current_user.xid.to_s],
						  :order => " updated_at desc "
						  )
	@bmorder = @bmorder.paginate(:page => @page, :per_page => 30)
end
end
