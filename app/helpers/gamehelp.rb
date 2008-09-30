class Gamehelp < ActionView::Base
    require 'pp'
	def help(helpid)
	    helpid = (cookies[:help] || helpid).to_i
		
	    helpmsg = ["你好，我是瓶子，欢迎来到海盗时代<br>
    如果你是第一次玩这个游戏，请务必仔细阅读一下教程，当然如果你迫不及待的想要自己尝试，也可跳过，并且可以随时通过右上方的“游戏帮助”按钮查看该教程</br>#{link_to '点击这里继续教程' , :controller => :home,:action => :index ,:help => (helpid+1)}",
	       "<style type=\"text/css\">#docklist{BORDER: #ee0000 1px solid;}#shiplist{BORDER: #0000EE 1px solid;}#friendlist{BORDER: #00EE00 1px solid;}</style>下面让我们来熟悉一下游戏界面</br><span style=\"color:red\">红线框出的区域</span>为你的小岛，一共有四个码头，每个人都有四个码头，其中前三个是私人码头，你的好友可以到你的私人码头上来抢劫，你必须保卫你的码头不受攻击。当然，你也可以去抢劫你的好友的码头，别让他发现了哦。</br><span style=\"color:blue\">蓝线框出的区域</span>为你的船只，你可以通过这里查看你的所有船只的状态，并且抢劫的时候也可以在此选择出战船只</br><span style=\"color:green\">绿线框出的区域</span>为你的好友列表，你通过点击好友的名字可以进入他们的小岛，对他们进行抢劫</br>#{link_to '接下来学习如何抢劫' , :controller => :home,:action => :friend ,:help => (helpid+1)}",
		   "这是就是你的好友的小岛了，当你点击导航栏“好友岛屿”时，就会随机的进入你一个好友的小岛，先在“我的船只”中选择你的船，点击下面的码头下面对应的“抢劫码头X”就可以进行抢劫了，先别急，听我说完</br>抢劫的金币是随时间增加而增加的，也就是说你在他岛上抢得越久，得到的钱就越多，最多一次能抢1000金币</br>你可以随时把你的船开到别人的岛屿上去抢劫，就可以得到钱了</br><span style=\"color:red\">注意：你必须把船开走，你抢到的钱才是你的，如果在你抢劫的期间被对方击退，则钱归他，同样如果别人抢劫你的时候你把别人击退TA抢的钱归你</span></br>#{link_to '接下来学习如何买船' , :controller => :shop,:action => :index ,:help => (helpid+1)}",
			   "<style type=\"text/css\">#showgoldinfo{BORDER: #ee0000 1px solid;}</style>在这里有各种各样的船，<span style=\"color:red\">红线框出的区域</span>为你现在的金币数，只要你有足够的钱，可以买很多的船，并且你可以到“我的船只”里面把你现有的穿卖掉，可以得到船原价的50%</br>#{link_to '点击继续教程' , :controller => :home,:action => :index ,:help => (helpid+1)}",
		   "好啦，教程就到这里结束了，开始你的海盗生涯吧"
	             ]
	    #pp "-------------helpid:#{helpid}--------------"
		
	    if helpid != 0 
			@help = '<div style="BORDER-RIGHT: #d8dfea 7px solid; BORDER-TOP: #d8dfea 7px solid; BACKGROUND: #fff; MARGIN: 0px 0px 10px; BORDER-LEFT: #d8dfea 7px solid; LINE-HEIGHT: 20px; BORDER-BOTTOM: #d8dfea 7px solid"><div style="BORDER-RIGHT: #3b5888 1px solid; PADDING-RIGHT: 10px; BORDER-TOP: #3b5888 1px solid; PADDING-LEFT: 10px; BACKGROUND: #fffeed; PADDING-BOTTOM: 10px; BORDER-LEFT: #3b5888 1px solid; PADDING-TOP: 10px; BORDER-BOTTOM: #3b5888 1px solid; POSITION: relative;text-align:center"><p><strong>'
			@help += helpmsg[helpid-1]
			@help += '</strong></p></div></div>'
			cookies[:help] = "#{helpid +1}"
		end
		#pp "-------------@cookies[:help]:#{cookies[:help]}--------------"
		@help
	end	
	
end