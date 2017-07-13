require_relative './post'
require_relative './link'
require_relative './task'
require_relative './memo'

puts "Привет, я твой блокнот."
puts "Что хотите записать в блокнот?"

choises = Post.post_types

choise = -1
until choise.between?(0, choises.size-1)
  choises.each_with_index {|type, index| puts "\t#{index}. #{type}"}

  choise = STDIN.gets.to_i
end

entry = Post.create(choise)
entry.read_from_console
entry.save

puts "Запись сохранена."