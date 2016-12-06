require "pp"
require "open3"

TEST_DATA = <<EOS
###########
S:#:::::# #
#:#:###:# #
#:::#:::# #
#####:### #
#:::::#   #
#:### # ###
#:::# # # #
###:### # #
#  :::::::G
###########
EOS

expected = TEST_DATA.each_line.map(&:chomp).map { |l|
  l + "\n"
}.join.chomp
stdin_data = expected.gsub(":", " ")
# stdout, status = *Open3.capture2("./solve.rb", stdin_data: stdin_data)
stdout, status = *Open3.capture2("ruby ./solve.rb", stdin_data: stdin_data)
stdout.gsub!(/((\r)?\n)*\z/m, "")

puts(<<EOS)
## input

#{stdin_data}

## output

#{stdout}

## result

#{(expected == stdout).inspect}
EOS
