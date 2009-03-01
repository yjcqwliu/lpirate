p "start"
@count = 0
p @count
user = User.find(:all,:conditions =>" updated_at = created_at ",:limit => 10000)
user.each do |u|
	@count = @count + 1
	p @count
	u.usership.each do |ship|
		ship.destroy
	end
	u.destroy
end