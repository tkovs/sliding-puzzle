require_relative 'getkeys'

class Table
    def initialize(size)
        table = (0 .. size*size -1).to_a
        @grid = table.shuffle.each_slice(size).to_a
    end

    def show_table
        @grid.map{|row| puts "#{row}"}
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
        else
            return false
        end
    end

    def loop_game
        show_table
        move = read_char
        unless move == "q"
            moviment(move)
            loop_game
        end
    end
end

Table.new(4).loop_game
