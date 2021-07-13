class String
  def red; "\e[31m#{self}\e[0m" end
  def blue; "\e[34m#{self}\e[0m" end
end

def month(k)
  mon = { 1 => 'Jan' , 2 => 'Feb' , 3 => 'Mar'}
  return mon[k]
end
#File Name
def filename()
  year = ARGV[1].split('/')
  array =ARGV[2].split('/')
  folder= array[3]
  filename= array[3]+"_"+year[0]+"_"+month(year[1].to_i)
  pf = folder+"/"+filename+".txt"
  return pf
end
# Average Temperature or Humidity
def averageTemp()
  data=[],hightemp=[],lowtemp=[],humidity=[]
  path = filename()
  file = File.open(path)
  file_data = file.readlines[2..32]
  for j in file_data
    hightemp.push(j.split(',')[1].to_i)
    lowtemp.push(j.split(',')[3].to_i)
    humidity.push(j.split(',')[7].to_i)
  end
  puts 'Average Highest Temperature: ' + (hightemp.sum(0.0) / hightemp.size).round.to_s + 'C'
  puts 'Average Lowest Temperature: '+ (lowtemp.sum(0.0) / lowtemp.size).round.to_s + 'C'
  puts 'Average Humidity: ' + (humidity.sum(0.0) / humidity.size).round.to_s + '%'
end
# Barchart
def barchart()
  high,low=[],[]
  daycount = 1
  count = 0
  path = filename()
  file = File.open(path)
  file_data = file.readlines[2..32]
  for j in file_data
    high.push(j.split(',')[1].to_i)
    low.push(j.split(',')[3].to_i)
  end
  for i in (0...high.length)
    print daycount
    a=high[count]
    b=low[count]
    for j in (0...a)
      print "+".red
    end
    puts a.to_s + 'C'
    print daycount
    for k in (0...b)
      print "+".blue
    end
    puts b.to_s + 'C'
    count += 1
    daycount += 1
  end
end
#fileread
def fileread(fd)
  htemp,ltemp,day,humidity=[],[],[],[]
  for j in fd
    htemp.push(j.split(',')[1].to_i)
    ltemp.push(j.split(',')[3].to_i)
    day.push(j.split(',')[0])
    humidity.push(j.split(',')[7].to_i)
  end
  htemp.map! { |x| x || 0 }
  ltemp.map! { |x| x || 0 }
  humidity.map! { |x| x || 0 }
end
# Temperature
def temperature()
  mon=['Jan','Mar']
  max, min, avg = 0, 100, 0
  htemp,ltemp,day,humidity=[],[],[],[]
  for i in (0...mon.length)
    year = ARGV[1]
    array =ARGV[2].split('/')
    folder= array[3]
    filename= array[3]+"_"+year+"_"+mon[i]
    path = folder+"/"+filename+".txt"
    file = File.open(path)
    file_data = file.readlines[2..32]
    for j in file_data
      htemp.push(j.split(',')[1].to_i)
      ltemp.push(j.split(',')[3].to_i)
      day.push(j.split(',')[0])
      humidity.push(j.split(',')[7].to_i)
    end
    htemp.map! { |x| x || 0 }
    ltemp.map! { |x| x || 0 }
    humidity.map! { |x| x || 0 }
    if htemp.max > max
      max= htemp.max
    end
    if ltemp.min < min
      min = ltemp.min
    end
    s = (humidity.sum(0.0) / humidity.size).round
    if s > avg
      avg = s
    end
  end
  puts "Highest: #{max.to_s}C"
  puts "Lowest:  #{min.to_s}C"
  puts "Humidity #{s.to_s}%"
end
#MAIN
condition = ARGV[0]
if condition == '-a'
  averageTemp()
elsif condition == '-c'
  barchart()
elsif condition == '-e'
  temperature()
end
