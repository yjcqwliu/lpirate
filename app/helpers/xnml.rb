class Ml
def self.name(attribute)
   ml = "<xn:name "
   attribute.each do |key,value| 
      ml += "#{key}=\"#{value}\" "
   end
   ml += "/>"
end
def self.userpic(attribute)
   ml = "<xn:profile-pic "
   attribute.each do |key,value| 
      ml += "#{key}=\"#{value}\" "
   end
   ml += "/>"
end
def self.iframe(attribute)
   ml = "<xn:iframe "
   attribute.each do |key,value| 
      ml += "#{key}=\"#{value}\" "
   end
   ml += "/>"
end
def self.image(imgcase,img=true)
   if img
   ml = "<img src=\""
   else
   ml = ""
   end 
   case imgcase 
       when "dock"
	      ml += "http://fmn015.xnimg.cn/fmn015/pic001/20080924/00/50/large_4Zd9_5658n200066.jpg"
	   when "small_skull"
	      ml += "http://fmn001.xnimg.cn/fmn001/pic001/20080924/16/55/large_7Bq8_3172b198177.jpg"
	   when "add_att"
	      ml += "http://fmn020.xnimg.cn/fmn020/groupalbum/20081022/16/18/L351360320024OXC.jpg"
	   when "weblpirate_01"
	      ml += "http://i170.photobucket.com/albums/u258/taweili/weblpirate_01-1.jpg"
	   when "weblpirate_02"
	      ml += "http://fmn025.xnimg.cn/fmn025/groupalbum/20081026/14/21/L210855432179YAN.jpg"
	   when "weblpirate_03"
	      ml += "http://fmn016.xnimg.cn/fmn016/groupalbum/20081026/11/02/L017558064329GAR.jpg"
	   when "weblpirate_04"
	      ml += "http://fmn020.xnimg.cn/fmn020/groupalbum/20081026/11/02/L017575743563GAR.jpg"
	   when "weblpirate_05"
	      ml += "http://fmn016.xnimg.cn/fmn016/groupalbum/20081026/11/02/L017579072831GAR.jpg"
	   when "weblpirate_06"
	      ml += "http://fmn018.xnimg.cn/fmn018/groupalbum/20081026/11/02/L017581936013GAR.jpg"
	   when "weblpirate_07"
	      ml += "http://fmn020.xnimg.cn/fmn020/groupalbum/20081026/11/03/L020266758509GAR.jpg"
	   when "weblpirate_08"
	      ml += "http://fmn019.xnimg.cn/fmn019/groupalbum/20081026/11/03/L020480553440GAR.jpg"
	   when "weblpirate_09"
	      ml += "http://fmn022.xnimg.cn/fmn022/groupalbum/20081026/14/13/L162611412214YAN.jpg"
	   when "weblpirate_10"
	      ml += "http://fmn021.xnimg.cn/fmn021/groupalbum/20081026/14/13/L162697461022YAN.jpg"
	   when "weblpirate_11"
	      ml += "http://fmn023.xnimg.cn/fmn023/groupalbum/20081026/14/13/L162753539201YAN.jpg"
	   when "weblpirate_12"
	      ml += "http://fmn018.xnimg.cn/fmn018/groupalbum/20081026/11/04/L025193110263GAR.jpg"
	   when "weblpirate_13"
	      ml += "http://fmn019.xnimg.cn/fmn019/groupalbum/20081026/11/04/L025201120862GAR.jpg"
	   when "weblpirate_14"
	      ml += ""
	   when "weblpirate_15"
	      ml += "http://fmn019.xnimg.cn/fmn019/groupalbum/20081026/11/04/L025318255810GAR.jpg"
	   when "weblpirate_16"
	      ml += "http://fmn019.xnimg.cn/fmn019/groupalbum/20081026/11/04/L025318255810GAR.jpg"
	   when "weblpirate_17"
	      ml += "http://fmn015.xnimg.cn/fmn015/pic001/20080924/00/50/large_4Zd9_5658n200066.jpg"
	   when "weblpirate_18"
	      ml += "http://fmn001.xnimg.cn/fmn001/pic001/20080924/16/55/large_7Bq8_3172b198177.jpg"
	   when "weblpirate_19"
	      ml += "http://fmn019.xnimg.cn/fmn019/groupalbum/20081026/11/04/L027354844483GAR.jpg"
	   when "weblpirate_20"
	      ml += "http://fmn025.xnimg.cn/fmn025/groupalbum/20081026/12/07/L406439698578BEN.jpg"
	   when "weblpirate_23"
	      ml += "http://i170.photobucket.com/albums/u258/taweili/weblpirate_23-1.jpg"
	   when "weblpirate_25"
	      ml += "http://i170.photobucket.com/albums/u258/taweili/weblpirate_25.jpg"
	   when "buttonhelp"
	      ml += "http://fmn022.xnimg.cn/fmn022/groupalbum/20081026/14/26/L239324144229YAN.jpg"
	   when "buttonbbs"
	      ml += "http://fmn019.xnimg.cn/fmn019/groupalbum/20081026/13/55/L055104885646TON.jpg"
	   when "buttoninvite"
	      ml += "http://fmn019.xnimg.cn/fmn019/groupalbum/20081026/13/55/L055098862810TON.jpg"
	   
   end
   if img
   ml += "\" border=\"0\" >"
   end 
   ml
end

def self.invite_form(attribute)
   ml = "<xn:invite-form  "
   attribute.each do |key,value| 
      ml += "#{key}=\"#{value}\" "
   end
   ml += ">"
end

def self.multi_friend_selector(attribute)
   ml = "<xn:multi-friend-selector  "
   attribute.each do |key,value| 
      ml += "#{key}=\"#{value}\" "
   end
   ml += "/>"
end

def self.end_invite_form
   ml = '</xn:invite-form>'
end

end