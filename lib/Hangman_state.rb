require 'yaml'

module State
    @@filename

    def save_game
        Dir.mkdir 'saved' unless Dir.exist? 'saved'
        @@filename = "#{Dir['saved'].length}_game.yaml"
        File.open("saved/#{@@filename}", 'w') { |file| file.write save_to_yaml }
    end

    def save_to_yaml
        YAML.dump ({
            :code => @code,
            :decoded => @decoded,
            :clues => @clues,
            :round => @round
          })
    end

    def load_saved_file
        if Dir.empty?("saved")
            puts "You have no saves."
        else
            file = YAML.load(File.read("saved/#{@@filename}"))
            @code = file[:code]
            @decoded = file[:decoded]
            @clues = file[:clues]
            @round = file[:round]
        end
    end
end