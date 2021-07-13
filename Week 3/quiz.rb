require "csv"
require "time"
require 'timeout'

question = []
answer = []
count = 0

puts "Enter Filename: "
filename = gets.to_s
f = filename + '.csv'
File.rename("problems.csv",f)

filename = File.open(f, "r");
CSV.foreach(filename) do |row|
  question.push(row[0])
  answer.push(row[1])
end

puts "Enter time for Quiz: "
time = gets.chomp.to_i

begin
  Timeout::timeout(time) do
    puts 'Press Ente Key to Start Quiz'
    key= gets
    if key == "\n"
      for i in (0..11)
      puts question[i]
      ans = gets.to_i
        if ans == answer[i].to_i
        count += 1
        end
      end
    end
  end
rescue Timeout::Error => e
  puts "End"
end
puts "Correct Answer #{count}/12"
