module Notice_show
   extend ActionView::Helpers::UrlHelper
   def self.show(notice)
       case notice.ltype
	   when 1
	       re = ["#{url_to_island(notice.from_xid)}船长驾驶他的#{notice.column2}在#{url_to_island(notice.to_xid)}的岛上烧杀抢掠一番，抢劫了#{notice.column1}金币","#{url_to_island(notice.from_xid)}船长一边唱着“我是个大盗贼，什么都不怕”一边开着他的#{notice.column2}带着从#{url_to_island(notice.to_xid)}的岛上抢来的#{notice.column1}金币和一群美女悠闲的离开了"].rand
	   
	    when 2
	       re = ["#{url_to_island(notice.from_xid)}船长成功的击退了#{url_to_island(notice.to_xid)}的进攻，夺回了#{notice.column1}金币","#{url_to_island(notice.to_xid)}被#{url_to_island(notice.from_xid)}船长一炮打回老家，抢劫行动宣告失败，留下了#{notice.column1}金币归#{url_to_island(notice.from_xid)}所有了"].rand
	   
	   when 3
	       re = "#{url_to_island(notice.from_xid)}接受了邀请，加入了海盗时代，#{url_to_island(notice.to_xid)}获得3000金币和1海盗币"
	   
	   when 10
	       re = "#{url_to_island(notice.from_xid)}踏入了海盗时代，从自己的港口收取了300金币保护费"
	   
	   end
       re
   end
   
   def self.url_to_island(xid)
	    url = "<a href=\"#{url_for  :controller => :home , :action => :friend ,:id => xid }\">#{Ml.name({:uid=>xid})}</a>"
   end

end