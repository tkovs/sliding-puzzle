require_relative 'getkeys'

class Table
    def initialize(size)
        table =  (1.. size*size -1).to_a.push(0)
        @grid = table.each_slice(size).to_a
        muddle
    end

    def show_table
        @grid.each{|row| row.each{|element| print cell(element) + ' '} and puts }
    end

    def cell(value)
        return "#{value.to_s.rjust(2, '0')}" unless value.eql?(0)

        return '  '
    end

    def muddle
        moviments = (@grid.length ** 2) * 10
        possibilities = [UP_ARROW, DOWN_ARROW, LEFT_ARROW, RIGHT_ARROW]
        
        moviments.times do
            moviment(possibilities[rand 4])
        end
    end

    def moviment(move)
        if valid?(move)
           /r_ = row _, c_ = column _
            _n = _ next, _c = _ current/
            rc, cc = white_row, white_column
            rn, cn = rc, cc

            if    move == UP_ARROW    then rn += 1
            elsif move == DOWN_ARROW  then rn -= 1
            elsif move == LEFT_ARROW  then cn += 1
            elsif move == RIGHT_ARROW then cn -= 1
            end
            
            @grid[rc][cc], @grid[rn][cn] = @grid [rn][cn], @grid[rc][cc]
        end
    end

    def white_row #row that contains the white space (0 here)
        @grid.find_index{|row| row.include?(0)}
    end

    def white_column #column that contains the white space (0 here)
        @grid.map{|row| row.find_index(0)}.compact.first
    end

    def valid?(move)
        case move 
            when UP_ARROW
                return true unless white_row.eql?(@grid.size-1)
            when DOWN_ARROW
                return true unless white_row.eql?(0)
            when LEFT_ARROW
                return true unless white_column.eql?(@grid.size-1)
            when RIGHT_ARROW
                return true unless white_column.eql?(0)
        end

        return false
    end

    def win?
        return false unless @grid.flatten.last.eql?(0)

        list = @grid.flatten
        list.pop
        return list.each_cons(2).all?{|a, b| a <= b}
    end

    def loop_game
        start_time = Time.now

        while !win?
            system "clear" or "cls"
            show_table
            move = read_char
            break if move == "q"
            
            moviment(move)
        end

        end_time = Time.now

        system "clear" or system "cls"
        show_table
        puts "You won! Just #{end_time - start_time} seconds" if win?
        return win?
    end

    def play
        loop_game
    end
end

Table.new(4).play
