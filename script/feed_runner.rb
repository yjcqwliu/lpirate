start_time = Time.now
puts "start:#{start_time}"
def show_notice(notice)
       case notice.ltype
	   when 1
	       re = ["#{url_to_island(notice.from_xid)}船长驾驶他的#{notice.column2}在#{url_to_island(notice.to_xid)}的岛上烧杀抢掠一番，抢劫了#{notice.column1}金币","#{url_to_island(notice.from_xid)}船长一边唱着“我是个大盗贼，什么都不怕”一边开着他的#{notice.column2}带着从#{url_to_island(notice.to_xid)}的岛上抢来的#{notice.column1}金币和一群美女悠闲的离开了"].rand
	   
	    when 2
	       re = ["#{url_to_island(notice.from_xid)}船长成功的击退了#{url_to_island(notice.to_xid)}的进攻，夺回了#{notice.column1}金币","#{url_to_island(notice.to_xid)}被#{url_to_island(notice.from_xid)}船长一炮打回老家，抢劫行动宣告失败，留下了#{notice.column1}金币归#{url_to_island(notice.from_xid)}所有了"].rand
	   
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
	       re = "#{url_to_captain(notice.from_xid)}花了#{notice.column1}金币把#{url_to_captain(notice.to_xid)}从#{url_to_captain(notice.column2)}手上雇佣了下来"
	   end
       re
   end
   
   def url_to_island(xid)
	    url = "<a href=\"http://apps.xiaonei.com/lpirate/home/friend/#{xid}\"><xn:name uid=\"#{xid}\"/></a>"
   end
   def url_to_captain(xid)
	    url = "<a href=\"http://apps.xiaonei.com/lpirate/captain/show/#{xid}\"><xn:name uid=\"#{xid}\"/></a>"
   end
   
Notice.find(:all, :conditions => [" sented is null  " ],:order => " updated_at desc ", :limit => 5000).each do |notice|
  begin
   current_time = Time.now
   if current_time - start_time > 9.minute
   puts "end by timeout"
   break
   end
   content = show_notice(notice)
    if notice.ltype != 10 
		res_note = notice.user.xn_session.invoke_method("xiaonei.notifications.send", 
														:to_ids => notice.to_xid, 
														:notification => content)

	end
    if notice.ltype != 11 
		res_feed = notice.user.xn_session.invoke_method("xiaonei.feed.publishTemplatizedAction", 
														:title_data => { 
														}.to_json,
														:body_data => { 
														  :content => content
														}.to_json,
														:template_id => (rand(10)+1))
    end
    puts "#{current_time}: process user #{notice.user.id}:  #{res_feed.inspect} #{res_note.inspect}"
    
    notice.sented = true
	notice.noticed = true
    notice.save
  rescue Exception => exp
    puts "exp: #{exp.inspect}"
  end
end


