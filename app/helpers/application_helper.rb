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
	
	def show_notice(notice)
       case notice.ltype
	   when 1
	       re = ["#{url_to_island(notice.from_xid)}船长驾驶他的#{h notice.column2}在#{url_to_island(notice.to_xid)}的岛上烧杀抢掠一番，抢劫了#{h notice.column1}金币","#{url_to_island(notice.from_xid)}船长一边唱着“我是个大盗贼，什么都不怕”一边开着他的#{h notice.column2}带着从#{url_to_island(notice.to_xid)}的岛上抢来的#{h notice.column1}金币和一群美女悠闲的离开了"].rand
	   
	    when 2
	       re = ["#{url_to_island(notice.from_xid)}船长成功的击退了#{url_to_island(notice.to_xid)}的进攻，夺回了#{h notice.column1}金币","#{url_to_island(notice.to_xid)}被#{url_to_island(notice.from_xid)}船长一炮打回老家，抢劫行动宣告失败，留下了#{h notice.column1}金币归#{url_to_island(notice.from_xid)}所有了"].rand
	   
	   when 3
	       re = "#{url_to_island(notice.from_xid)}接受了邀请，加入了海盗时代，#{url_to_island(notice.to_xid)}获得3000金币和1海盗币"
	   
	   when 10
	       re = "#{url_to_island(notice.from_xid)}踏入了海盗时代，从自己的港口收取了300金币保护费"
	   when 11
	       re = "#{url_to_island(notice.from_xid)}开着TA的商船与#{url_to_island(notice.to_xid)}进行友好贸易，赚了#{notice.column1}金币"
	   when 12
	       re = "#{url_to_island(notice.from_xid)}开着TA的商船向#{url_to_island(notice.to_xid)}倒卖了大量商品，赚了#{notice.column1}金币"
	   when 13
	       re = "#{url_to_captain(notice.from_xid)}花了#{notice.column1}金币把#{url_to_captain(notice.to_xid)}雇佣成了船长"
	   when 14
	       re = "#{url_to_captain(notice.from_xid)}花了#{notice.column1}金币把#{url_to_captain(notice.column2)}从#{url_to_captain(notice.to_xid)}手上雇佣了下来"
	   end
       re
   end
   
   def url_to_island(xid)
	    url = "<a href=\"#{url_for  :controller => :home , :action => :friend ,:id => xid }\">#{Ml.name({:uid=>xid})}</a>"
   end
   def url_to_captain(xid)
	    url = "<a href=\"#{url_for  :controller => :captain , :action => :show ,:id => xid }\">#{Ml.name({:uid=>xid})}</a>"
   end
end
