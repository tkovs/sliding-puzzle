require_relative 'getkeys'

class Table
    def initialize(size)
        table =  (1.. size*size -1).to_a.push(0)
        @grid = table.each_slice(size).to_a
        muddle
    end

    def show_table
        #@grid.map{|row| row.map {|x| print x.to_s.rjust(2, "0") + ' '} and puts}

        @grid.each do |row|
            row.each do |element|
                unless element == 0
                    print '[' + element.to_s.rjust(2, "0") + '] '
                else
                    print '     '
                end
            end

            puts
        end
    end

    def muddle
        moviments = 4 * ((@grid.length ** 2) * 5)
        possibilities = [UP_ARROW, DOWN_ARROW, LEFT_ARROW, RIGHT_ARROW]
        moviments.times do
            moviment(possibilities[rand 4])
        end
    end

    def moviment(move)
        if valid?(move)
            row_current, column_current = row, column
            row_next, column_next = row_current, column_current

            row_next += 1 if move == UP_ARROW
            row_next -= 1 if move == DOWN_ARROW
            column_next += 1 if move == LEFT_ARROW
            column_next -= 1 if move == RIGHT_ARROW

            temporary_variable = @grid[row_current][column_current]
            @grid[row_current][column_current] = @grid[row_next][column_next]
            @grid[row_next][column_next] = temporary_variable
        end
    end

    def row #row that contains the white space (0 here)
        @grid.find_index{|row| row.include?(0)}
    end

    def column #column that contains the white space (0 here)
        @grid.map{|row| row.find_index(0)}.compact.first
    end

    def valid?(move)
        if move == UP_ARROW
            return true unless row.eql?(@grid.size-1)
        elsif move == DOWN_ARROW
            return true unless row.eql?(0)
        elsif move == LEFT_ARROW
            return true unless column.eql?(@grid.size-1)
        elsif move == RIGHT_ARROW
            return true unless column.eql?(0)
        end

        return false
    end

    def win?
        return false if @grid.flatten.last != 0

        list = @grid.flatten
        list.pop
        return list.each_cons(2).all?{|a, b| a <= b}
    end

    def loop_game
        while !win?
            system "clear"
            show_table
            move = read_char
            break if move == "q"
            
            moviment(move)
        end

        system "clear"
        show_table
        puts 'Voce venceu!!' if win?
        return win?
    end

    def play
        loop_game
    end
end

Table.new(4).play
