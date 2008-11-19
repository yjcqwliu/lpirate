class FightController < ApplicationController
	def index
		if @current_user.usership.length < 3
			xn_redirect_to("home/index",{:notice => "拥有船只超过三艘的玩家才能进入战场"})
		else
			@current_user.init_fight
			back_thew
			@fight_teg = Fight.find(:all,:include => :user,:conditions =>[" ship_count >= ? ",@current_user.fight.ship_count], :order => " ship_count asc ")
			if @fight_teg.length < 10
				@fight_teg = Fight.find(:all,:include => :user, :order => " ship_count asc ")
			end
			@page = params[:page] || 1
			@fight_teg = @fight_teg.paginate(:page => @page, :per_page => 10)
		end
	end
	def fight
		if xid = params[:id]
			if @current_user.fight.thew < @current_user.fight.maxthew
				fight_user = User.find_by_xid(xid)
				if fight_user.fight && fight_user.fight.fighted && fight_user.usership.length >= 3
					@current_user.fight.thew = @current_user.fight.thew + 1
					@current_user.fight.save
					if rand(100) < (@current_user.fight.attack * 1.0 / (fight_user.fight.attack + @current_user.fight.attack)) * 100
						rob_money = rand(1000) + 1000
						@current_user.gold += rob_money
						@current_user.save
						#fight_user.gold -= rob_money
						#fight_user.save
						xn_redirect_to("fight",{:notice => "攻击获胜！你的船队所向披靡，从TA那里抢劫了#{rob_money}金币"})
					else
						rob_money = rand(1000) + 1000
						@current_user.gold -= rob_money
						@current_user.save
						fight_user.gold += rob_money
						fight_user.save
						xn_redirect_to("fight",{:notice => "攻击失败！你的船队被打败了，反被洗劫了#{rob_money}金币"})
					end
					
				else
					xn_redirect_to("fight",{:notice =>"TA的剩余船只数目小于3，或者未参加海战"})
				end
			else
				xn_redirect_to("fight",{:notice =>"你已经没有战斗力了，战斗力需要每两小时恢复1点"})
			end
		else
			xn_redirect_to("fight")
		end
	end
private
	def back_thew
		if 2.hour < Time.now - @current_user.fight.last_add_thew
			pp "----(Time.now - @current_user.fight.last_add_thew)#{(Time.now - @current_user.fight.last_add_thew)}---2.hour#{2.hour}-(Time.now - @current_user.fight.last_add_thew) / 2.hour#{(Time.now - @current_user.fight.last_add_thew) / 2.hour}--"
			add_thew = ((Time.now - @current_user.fight.last_add_thew) / 2.hour).to_i
			@current_user.fight.thew -= add_thew
			@current_user.fight.thew = @current_user.fight.maxthew if @current_user.fight.thew > @current_user.fight.maxthew
			@current_user.fight.last_add_thew = Time.now - (Time.now - @current_user.fight.last_add_thew) % 2.hour
			@current_user.fight.save
		end
	end
end
