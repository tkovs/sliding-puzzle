require_relative 'getkeys'

class Table
    def initialize(size)
        table = (0 .. size*size -1).to_a
        @grid = table.shuffle.each_slice(size).to_a
    end

    def show_table
        @grid.map{|row| puts "#{row}"}
        #puts @grid.find_index{|row| row.include?(0)}
        #puts @grid.to_s
    end

    def moviment
        move = read_char

        if move == "\e[A"
            if (@grid.find_index{|row| row.include?(0)} == @grid.size-1)
                puts 'Não pode manow'
            end
        end        
    end

    def valid?(move)
        row = @grid.find_index{|row| row.include?(0)}

        if move == "\e[A" #seta pra cima
            unless row == @grid.size-1
                # can do something
            end
        end
    end
end

table = Table.new(4)
table.show_table
table.moviment
