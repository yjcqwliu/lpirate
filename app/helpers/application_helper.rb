# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    require 'xnml'
	require 'gamehelp'
	def conversion(cmp_time) #����ʱ���
	    time = 18000 #������ʱ�䣬�˴�Ϊ Сʱ*3600����5Сʱ
		tt = cmp_time / time
		if tt > 1 
		   @conversion =  1000
		else
		   @conversion = 1000 * tt
		end 
	end
end
