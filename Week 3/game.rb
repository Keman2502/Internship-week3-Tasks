def blackjack
  hand = []
  play = true
  deck(hand)
  deck(hand)
  sum(hand)
  dealerhand=[]
  dealer(dealerhand)
  play = hit_stand(hand,dealerhand)
  if play == true
    hit_stand(hand,dealerhand)
  end
end

def result(hand, dealerhand)
  pcheck = total(hand)
  dcheck = total(dealerhand)
  if pcheck < dcheck && dcheck > 21
    puts "Dealer Burst"
  elsif pcheck > dcheck && dcheck < 21
    puts "You Won this game..!"
  end
end

def stand(hand ,dealerhand)
  puts "Dealer hidden card: #{dealerhand[0]}"
  sum_dealer(dealerhand)
  check = total(dealerhand)
  check2 = total(hand)
  if check2 > check
    deck(dealerhand)
    sum_dealer(dealerhand)
  end
  result(hand,dealerhand)
end

def total(hand)
  count = 0
  hand.each do |num|
    count += num
  end
  count
end

def hit_stand(hand,dealerhand)
  puts "You want to hit or stand"
  option = gets.chomp.downcase
  if option == 'hit'
    deck(hand)
    total = sum(hand)
    if total > 21
      puts "Burst"
      play = false
    else
      play = true
    end
  else
    stand(hand,dealerhand)
    play = false
  end
end

def dealer_hand(dealerhand)
  myarray= [*(2..10),'Jack' , 'Arc', 'Queen' , 'King']
  check = myarray[rand(myarray.length)]
  if check.class == Integer
    dcard = check
  elsif check == 'Jack' || check == 'Queen' || check == 'King'
    dcard = 10
  else
    dcard = 11
  end
   dealerhand << dcard
end

def dealer(dealerhand)
  dealer_hand(dealerhand)
  dealer_hand(dealerhand)
  puts "Card in dealers hand: 1-Hidden 2-#{dealerhand[1]}"
end

def sum_dealer(hand)
  total = 0
  hand.each do |count|
    total += count
  end
  puts "The sum of the dealer card #{total} \n\n"
  total
end


def sum(hand)
  total = 0
  hand.each do |count|
    total += count
  end
  puts "The sum of the cards you have been dealt is #{total} \n\n"
  total
end

def deck(hand)
  myarray= [*(2..10),'Jack' , 'Arc', 'Queen' , 'King']
  check = myarray[rand(myarray.length)]
  if check.class == Integer
    card = check
  elsif check == 'Jack' || check == 'Queen' || check == 'King'
    card = 10
  else
    card = 11
  end
  puts "You have been dealt a card with a value of #{card}\n"
  hand << card
end

puts "To Start Game Enter YES "
play = gets.chomp.downcase
if play == "yes"
  blackjack
elsif play =="no"
  puts "Its okayy! Try some other day"
else
  puts "Wrong Input Try Again"
end
