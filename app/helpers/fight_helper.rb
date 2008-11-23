module FightHelper
	def show_fight_info(f)
		if f.won 
			resault = "你大叫一声\"fire！\"，一阵炮火硝烟过后你战胜了#{url_to_island(f.from_xid)}，并抢夺了#{f.money}金币"
		else
			resault = "你被#{url_to_island(f.from_xid)}打得一败涂地，被TA抢劫了#{f.money}金币" + link_to("还击", :controller => :fight ,:action => :fight, :id => f.from_xid)
		end
	end
	def url_to_island(xid)
	    url = "<a href=\"#{url_for  :controller => :home , :action => :friend ,:id => xid }\">#{Ml.name({:uid=>xid})}</a>"
   end
end
