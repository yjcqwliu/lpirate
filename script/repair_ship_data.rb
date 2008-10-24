usership = Usership.find(:all,:conditions => [" updated_at > ?" ,Time.now - 60.hour])
puts "--------usership.length:#{usership.length}---------------"
usership.each do |ship|
    	ship.attack=ship.ship.attack
		ship.capacity=ship.ship.capacity
		ship.robspeed=ship.ship.robspeed
		ship.save
        if ship.captain
		     puts ("------ship.captain:#{ship.captain.inspect}-------------")
		     ship.captain.add_att_to_usership
		end
		
		puts "ship_id:#{ship.id},ship.capacity:#{ship.capacity}"
end