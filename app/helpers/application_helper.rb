# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    require 'xnml'
	require 'gamehelp'
	def conversion(cmp_time,top=1000,speed=200) #传入时间差
	
	    time = fulltime(top , speed)*3600 #抢满的时间，此处为 小时*3600
		tt = cmp_time / time
		#pp("@@@@@@tt:#{tt}@@@@@time:#{time}@@@@cmp_time:#{cmp_time}@@")
		if tt > 1 
		   @conversion =  top
		else
		   @conversion = top * tt
		end 
		@conversion.to_i
	end

	def fulltime(top,speed)
	    t = top / (speed * 1.0)
	    #pp("----t:#{t}-----")
	    t
	end
	
	def usershipimg(usership)
	     outml = "<img src=\"#{usership.ship.img_url}\" title=\"#{h usership.name } 价格:#{h usership.ship.price}金币 货仓容量：#{usership.capacity}金币 #{h usership.ship.intro}\">"
	end
end
