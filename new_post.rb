require_relative './lib/post'
require_relative './lib/link'
require_relative './lib/task'
require_relative './lib/memo'

puts "Привет, я твой блокнот. Версия 2 + SQLite3"
puts "Что хотите записать в блокнот?"

choices = Post.post_types.keys

choice = -1
until choice.between?(0, choices.size-1)
  choices.each_with_index {|type, index| puts "\t#{index}. #{type}"}

  choice = STDIN.gets.to_i
end

entry = Post.create(choices[choice])
entry.read_from_console
id = entry.save_to_db


puts "Запись сохранена. id = #{id}"
