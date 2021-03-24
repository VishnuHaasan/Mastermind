class Game
  def initialize(coder,guesser)
    @coder = coder
    @guesser = guesser
  end

  def startGame
    @coder.getCode
    while !isGameOver(@coder.code,@guesser.code) do
      @guesser.getGuess
      puts @guesser.code
      startGuess(@coder.code,@guesser.code)
    end
    @guesser.winMessage
  end

  def startGuess(g_array,p_array)
    return if g_array == p_array
    count_same_position = countSamePosition(g_array,p_array)
    count_wrong_position = countWrongPosition(g_array,p_array)
    printClues(count_same_position,count_wrong_position)
  end

  def isGameOver(g,p)
    return true if g == p 
    return false
  end

  def countSamePosition(g_array,p_array)
    count = 0
    for i in 0..3 do
      count+=1 if g_array[i] == p_array[i]
    end
    return count
  end

  def countWrongPosition(g_array,p_array)
    count = 0
    for i in 0..3 do
      count+=1 if g_array.include?(p_array[i]) && p_array[i]!=g_array[i]
    end
    return count
  end

  def printClues(count_same_position,count_wrong_position)
    puts "The number of colors at the correct position are #{count_same_position} and the number of colors that are correct but in the wrong position are #{count_wrong_position}"
  end
end


class Human
  attr_reader :code,:name
  def initialize(name)
    @name = name
    @code = Array.new
  end

  def uniq?(a)
    return true if a == a.uniq
    return false
  end

  def getGuess
    flag = true
    while flag do
      puts "Enter your guessed colors seperated by a space[V,I,B,G,Y,O,R]: "
      k = gets.chomp.split(" ")
      if uniq?(k)
        flag = false
      elsif k == @code 
        puts "You have guessed your previous guess, choose a different one."
        flag = true
      else  
        puts "You have entered your guess with a repeating color, guess again."
        flag = true
      end
    end
    @code = k
  end

  def getCode
    flag = true
    while flag do 
      puts "Enter the secret code: "
      k = gets.chomp.split(" ")
      if uniq?(k)
        flag = false
      else
        flag = true
      end
    end  
    @code = k
  end

  def winMessage
    puts "You have won, Congratulations!"
  end
end


class Computer
  attr_reader :code,:name
  def initialize(name)
    @name = name
    @code = Array.new
    @guess_history = Array.new
  end

  def uniq?(a)
    return true if a == a.uniq
    return false
  end

  def getCode
    guessed_colors = Array.new
    i = 0
    while i<4 do
      k = ["V","I","B","G","Y","O","R"].sample
      if !guessed_colors.include?(k)
        guessed_colors.push(k)
        i+=1
      end
    end
    @code = guessed_colors
    puts "The computer is guessing..."
    sleep(2)
  end

  def getGuess
    guess = Array.new
    i= 0
    while i<4 do
      k = ["V","I","B","G","Y","O","R"].sample
      if !guess.include?(k)
        guess.push(k)
        i+=1
      end
      if i==4 && @guess_history.include?(guess)
        i = 0
        guess = Array.new
      end
    end
    @guess_history.push(guess)
    @code = guess
    puts "The computer is guessing..."
    sleep(2)
    puts "The computer's guess is #{guess}"
  end

  def winMessage
    puts "You have lost, good luck next time."
  end
end
puts "Shall we start the game[y/n]?"
char = gets.chomp
while char == "y" do
  p1 = Human.new("Me")
  p2 = Computer.new("Comp")
  puts "Who do you want to play as? press 1 for Coder and 2 for Guesser"
  n = gets.chomp.to_i
  if n == 1
    game = Game.new(p1,p2)
  elsif n == 2
    game = Game.new(p2,p1)
  end
  game.startGame
  puts "Do you want to play again?[y/n]"
  char = gets.chomp
end
puts "Goodbye have a nice day."
#////////

=begin
def generateRandomGuess
  guessed_colors = Array.new
  i = 0
  while i<4 do
    k = $array.sample
    if !guessed_colors.include?(k)
      guessed_colors.push(k)
      i+=1
    end
  end
  return guessed_colors
end
def hasGameEnded(g,p)
  return true if g == p 
  return false
end
def uniq?(a)
  return true if a == a.uniq
  return false
end
def getUserGuess(p)
  flag = true
  while flag do
    puts "Enter your guessed colors seperated by a space[V,I,B,G,Y,R]: "
    k = gets.chomp.split(" ")
    if uniq?(k)
      flag = false
    elsif k == p 
      puts "You have guessed your previous guess, choose a different one."
      flag = true
    else  
      puts "You have entered your guess with a repeating color, guess again."
      flag = true
    end
  end
    return k
end
def countSamePosition(g_array,p_array)
  count = 0
  for i in 0..3 do
    count+=1 if g_array[i] == p_array[i]
  end
  return count
end
def countWrongPosition(g_array,p_array)
  count = 0
  for i in 0..3 do
    count+=1 if g_array.include?(p_array[i]) && p_array[i]!=g_array[i]
  end
  return count
end
def printClues(count_same_position,count_wrong_position)
  puts "The number of colors at the correct position are #{count_same_position} and the number of colors that are correct but in the wrong position are #{count_wrong_position}"
end
def playRound(g_array,p_array)
  return if g_array == p_array
  count_same_position = countSamePosition(g_array,p_array)
  count_wrong_position = countWrongPosition(g_array,p_array)
  printClues(count_same_position,count_wrong_position)
end
def playGame
  guessed_colors = generateRandomGuess
  puts guessed_colors
  predicted_colors = Array.new
  while !hasGameEnded(guessed_colors,predicted_colors) do
    predicted_colors = getUserGuess(predicted_colors)
    playRound(guessed_colors,predicted_colors)
  end
  puts "You have guessed it right! Congratulations"
end
$array = ['V','I','B','G','Y','R']
playGame
=end
