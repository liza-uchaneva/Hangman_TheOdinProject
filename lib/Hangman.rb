require_relative 'Hangman_state.rb'
require_relative 'color.rb'

class Hangman
    attr_accessor :code, :decoded, :clues, :round

    include State

    def initialize(code = generate_code(),
                   decoded = "",
                   clues = "", 
                   round = 1)
        @code = code
        @decoded = decoded
        @clues = clues
        @round = round
        play()
    end

    def play 
        puts "Let's play Hangman!"
        puts "I thought of a word:"
        display_code()
        while true
            puts "Round: #{@round}"
            get_gues()

            if @decoded.length == @code.length
                puts "Congratulations, you've won!"
                break
            end

            @round += 1

            if @round == 11
                puts "Sorry, you lost!"
                puts "The word was: '#{@code}'"
                break
            end
        end 
    end

    def generate_code()
        dictionary = File.open('words.txt', 'r')
        words = []

        dictionary.each_line do |line|
            word = line.chop
            if word.length <= 12 && word.length >= 5 
                words.push(word)
            end
        end

        dictionary.close
        return words.sample
    end

    def display_code
        @code.split("").each do |char|
            if @decoded.include?(char)
                print char
            else
                print "_"
            end
        end
        puts " "
    end

    def display_clues
        puts "Letters you have already tried:"
        @clues.split("").each do |clue|
            if @decoded.include?(clue)
                print clue.green
            else
                print clue.red
            end
        end
        puts " "
    end

    def get_gues
        print "Enter a letter, full word, 'save' to save progress or 'load' to load your save:"
        input = gets.chomp
        if input == "save"
            save_game
            puts "The current state of the game has been saved."
            get_gues() 
        elsif input == "load"
            load_saved_file
            puts @round
            display_clues()
            get_gues()
        elsif input == @code
            input.split('').each do |char|
                if !@decoded.include?(char)
                    @decoded += char
                end
            end
        else
            check_guess(input)
        end        
    end

    def check_guess(input)
        if input.length != 1
            puts "Invalid answer"
            get_gues()            
        elsif @decoded.include?(input)
            puts "You have already guessed this letter, try again"
            get_gues() 
        elsif @code.include?(input)
            @decoded += input
            @clues += input
            display_code()
            display_clues()
        else
            @clues += input
            display_code()
            display_clues()
        end
    end
end