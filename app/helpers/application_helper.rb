# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    require 'xnml'
	require 'gamehelp'
	def conversion(cmp_time,top=1000) #����ʱ���
	    time = 1 #������ʱ�䣬�˴�Ϊ Сʱ*3600����5Сʱ
		tt = cmp_time / time
		if tt > 1 
		   @conversion =  top
		else
		   @conversion = top * tt
		end 
		@conversion.to_i
	end
end
