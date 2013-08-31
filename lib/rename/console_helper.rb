module ConsoleHelper
  COLORS_CODES = {
    :red => 31,
    :green => 32,
    :yellow => 33,
    :cyan => 36
  }.freeze

  def colorize string, color
    "\033[#{COLORS_CODES[color]}m#{string}\033[0m"
  end

  def prompt string
    print "#{string}: "
    gets.chomp
  end
end
