# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def conversion(cmp_time) #����ʱ���
	    time = 10800 #������ʱ�䣬�˴�Ϊ Сʱ*3600����3Сʱ
		tt = cmp_time / time
		if tt > 1 
		   @conversion =  1000
		else
		   @conversion = 1000 * tt
		end 
	end
end
