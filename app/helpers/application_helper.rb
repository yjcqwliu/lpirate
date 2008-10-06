# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    require 'xnml'
	require 'gamehelp'
	def conversion(cmp_time,top=1000) #传入时间差
	    time = 1 #抢满的时间，此处为 小时*3600，即5小时
		tt = cmp_time / time
		if tt > 1 
		   @conversion =  top
		else
		   @conversion = top * tt
		end 
		@conversion.to_i
	end
end
