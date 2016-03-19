#Code from: https://gist.github.com/acook/4190379

require 'io/console'

UP_ARROW = "\e[A"
DOWN_ARROW = "\e[B"
RIGHT_ARROW = "\e[C"
LEFT_ARROW = "\e[D"

# Reads keypresses from the user including 2 and 3 escape character sequences.
def read_char
  STDIN.echo = false
  STDIN.raw!

  input = STDIN.getc.chr
  if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end

ensure
  STDIN.echo = true
  STDIN.cooked!

  return input
end
