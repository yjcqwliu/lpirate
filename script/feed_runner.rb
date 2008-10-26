
puts "start"
Notice.find(:all, :conditions => [" sented is null  " ],:order => " updated_at desc ", :limit => 5000).each do |notice|
  begin
   current_time = Time.now
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


