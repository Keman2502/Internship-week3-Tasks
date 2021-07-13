print "Want to add Number (Y/N): "
num = gets.chomp.downcase
print "Want to add Alpha press (Y/N): "
alpha = gets.chomp.downcase
print "Want to add Special character press (Y/N): "
special= gets.chomp.downcase

if num == 'y'
  password = ('0'..'9').to_a
else
  password=[]
end

if alpha == 'y'
  password +=  ('A'..'Z').to_a + ('a'..'z').to_a
end

if special == 'y'
  password += ('!'..'/').to_a + (':'..'@').to_a
end

puts password.sort_by {rand}.join[0...10]



