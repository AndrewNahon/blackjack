require 'pry'

#1 Create deck
def create_deck
  cards = %w(2 3 4 5 6 7 8 9 10 J Q K A)
  suits = %w(Hearts Diamonds Clubs Spades)
  deck = []

  cards.each do |c|
    suits.each do |s|
      deck << [c, s]
    end
  end   
  deck += deck
  deck.shuffle 
end

def hand_total(hand)
#convert hand to an array of just values. 
#add each value to a total sum
#convert face cards to 10
#deal with the multiple value of Aces.
  total = 0
  values = hand.map {|card| card[0]}
  values.each do |v|
    if v.to_i != 0
      total += v.to_i
    elsif v != 'A'
      total += 10
    else
      total <= 10 ? total += 11 : total += 1
    end
  end
  total
end

def display_hand(hand)
  hand.each do |card| #card is [value, suit] array
    if card[0].to_i != 0
      puts "#{card[0]} of #{card[1]}"
    else
      case
      when card[0] == 'J'
        puts "Jack of #{card[1]}"
      when card[0] == 'Q'
        puts "Queen of #{card[1]}"
      when card[0] == 'K'
        puts "King of #{card[1]}"
      when card[0] == 'A'
        puts "Ace of #{card[1]}"
      end      
    end
  end  
end

def display_playerhand(hand)
  puts "You have: "
  display_hand(hand)
  puts "Total: #{hand_total(hand)}"
  puts ''
end

def display_computerhand(hand)
  puts "Dealer has: "
  display_hand(hand)
  puts "Total: #{hand_total(hand)}"
  puts ''
end

def check_blackjack(hand)
  if hand_total(hand) == 21
    puts "Congratulations! You got blackjack. You win!"
    exit
  end
end

def check_bust(hand)
  if hand_total(hand) > 21
    puts "Sorry, looks like you busted."
    exit
  end
end



#Start game. Create deck and deal two cards to player and computer each and display hands. Check for player blackjack.
deck = create_deck

playerhand = []
computerhand = []



playerhand << deck.pop
computerhand << deck.pop
playerhand << deck.pop
computerhand << deck.pop

display_playerhand(playerhand)
display_computerhand(computerhand)

check_blackjack(playerhand)

#Player's turn. The player will have the option to HIT or STAY. 
#If he chooses hit, he receives a new card and his hand is displayed. Check for 21 or bust. If neither is true, 
#He can hit or stay again. This process repeats until he chooses STAY. 

loop do

  puts "Do you want to 1) hit or 2) stay?"
  hit_stay = gets.chomp.to_i
  
  while ![1, 2].include?(hit_stay)
    puts "You must enter 1 or 2."
    hit_stay = gets.chomp.to_i
  end

  if hit_stay == 1
    playerhand << deck.pop
    puts "You were dealt #{playerhand.last[0]} of #{playerhand.last[1]}."
    puts ''
    check_blackjack(playerhand)
    check_bust(playerhand)
    display_playerhand(playerhand)
    sleep(1)
    next
  end

  break if hit_stay == 2
end

#Computer's turn. The computer will always hit if a) total < 17 or less than player's total.
#After each hit, check for bust and 21 and win. 

while hand_total(computerhand) < 17 && !(hand_total(computerhand) > 21) 
  computerhand << deck.pop
  puts "Dealer got #{computerhand.last[0]} of #{computerhand.last[1]}."
  puts ''
  sleep(1)

end

puts ''
display_computerhand(computerhand)

#Announce winner.

if (hand_total(computerhand) == hand_total(playerhand))
  puts "It's a tie."
elsif (hand_total(computerhand) < hand_total(playerhand)) || hand_total(computerhand) > 21
  puts "You win!" 
else
  puts "Dealer wins."
end



