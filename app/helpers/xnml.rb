class Ml
def name(attribute)
   ml = "<xn:name "
   attribute.each do |key,value| 
      ml += "#{key}=\"#{value}\" "
   end
   ml += "/>"
end
def userpic(attribute)
   ml = "<xn:profile-pic "
   attribute.each do |key,value| 
      ml += "#{key}=\"#{value}\" "
   end
   ml += "/>"
end
def image(imgcase)
   ml = "<img src=\""
   case imgcase 
       when "dock"
	      ml += "http://fmn015.xnimg.cn/fmn015/pic001/20080924/00/50/large_4Zd9_5658n200066.jpg"
	   when "small_skull"
	      ml += "http://fmn001.xnimg.cn/fmn001/pic001/20080924/16/55/large_7Bq8_3172b198177.jpg"
   end
   ml += "\" border=\"0\" >"
end
end