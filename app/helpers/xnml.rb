class Ml
def name(attribute)
   ml = "<xn:name "
   attribute.each do |key,value| 
      ml += "#{key}=\"#{value}\" "
   end
   ml += "/>"
end
end