current_time = Time.now
puts "start"
puts Notice.find(:all, :conditions => ["  sented is null or noticed is null " ],:order => " updated_at desc ").length
Notice.find(:all, :conditions => [" sented is null or noticed is null " ],:order => " updated_at desc ").each do |notice|
  begin
   # notifications = ["<xn:name uid='#{friend.user.xid}'/>在美容达人PK赛向你发出了站题，<a href='http://apps.xiaonei.com/beautypk/challenge/myreceive'>回答这些问题就可以和TA一决胜负了</]
   
    res_note = notice.user.xn_session.invoke_method("xiaonei.notifications.send", 
                                                    :to_ids => notice.to_xid, 
                                                    :notification => notice.content)
    if notice.ltype != 11 
    res_feed = notice.user.xn_session.invoke_method("xiaonei.feed.publishTemplatizedAction", 
                                                    :title_data => { 
                                                    }.to_json,
                                                    :body_data => { 
                                                      :content => notice.content
                                                    }.to_json,
                                                    :template_id => 1)
    end
    puts "#{current_time}: process user #{notice.user.id}:  #{res_feed.inspect} #{res_note.inspect}"
    
    notice.sented = true
	notice.noticed = true
    notice.save
  rescue Exception => exp
    puts "exp: #{exp.inspect}"
  end
end


