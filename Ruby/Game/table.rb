require_relative 'getkeys'

class Table
    def initialize(size)
        table = (0 .. size*size -1).to_a
        @grid = table.shuffle.each_slice(size).to_a
    end

    def show_table
        @grid.map{|row| puts "#{row}"}
    end

    def moviment
        move = read_char # from getkeys.rb file

        if valid?(move)
            # play
        end
    end

    def valid?(move)
        row = @grid.find_index{|row| row.include?(0)}

        if move == "\e[A" # up arrow
            return true unless row.eql?(@grid.size-1)
        end
    end
end

table = Table.new(4)
table.show_table
table.moviment
