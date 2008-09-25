# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def conversion(cmp_time) #传入时间差
	    time = 10800 #抢满的时间，此处为 小时*3600，即3小时
		tt = cmp_time / time
		if tt > 1 
		   @conversion =  1000
		else
		   @conversion = 1000 * tt
		end 
	end
end
