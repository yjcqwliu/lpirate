current_time = Time.now

Notice.find(:all, :conditions => ["  sented <> true or noticed <> true " ],:order => " updated_at desc ").each do |notice|
  begin
    notifications = [
                    "<xn:name uid='#{friend.user.xid}'/>在美容达人PK赛向你发出了站题，<a href='http://apps.xiaonei.com/beautypk/challenge/myreceive'>回答这些问题就可以和TA一决胜负了</a>"
                    ]
    res_note = notice.user.xn_session.invoke_method("xiaonei.notifications.send", 
                                                    :to_ids => notice.to_xid, 
                                                    :notification => notice.content)
    
    res_feed = user.xn_session.invoke_method("xiaonei.feed.publishTemplatizedAction", 
                                                    :title_data => { 
                                                    }.to_json,
                                                    :body_data => { 
                                                      :my_uid => user.xid,
                                                      :age => user.age,
                                                    }.to_json,
                                                    :template_id => 1)
    
    puts "#{current_time}: process user #{user.id}:  #{res_feed.inspect} #{res_note.inspect}"
    
    user.sent = true
    user.save
  rescue Exception => exp
    puts "exp: #{exp.inspect}"
  end
end


