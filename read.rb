require_relative './lib/post'
require_relative './lib/link'
require_relative './lib/task'
require_relative './lib/memo'
require 'optparse'

#id, limit, type
options = {}

OptionParser.new do |opt|
  opt.banner = 'Usage read.rb [options]'

  opt.on('-h', 'Prints this help') do
    puts opt
    exit
  end

  opt.on('--type POST_TYPE', 'какой тип поста показывать (по умолчанию любой)') { |o| options[:type] = o }
  opt.on('--id POST_ID', 'если задан id - показываем этот пост') { |o| options[:id] = o }
  opt.on('--limit NUMBER', 'сколько последних постов показывать (по умолчанию все)') { |o| options[:limit] = o }
end.parse!

unless options[:id].nil?
  #в качестве аргументов принимаем и type и id
  result = Post.find_by_id(options[:type], options[:id])
else
  result = Post.find_all(options[:limit], options[:type])
end
#result = Post.find(options[:limit], options[:type], options[:id])

if result.is_a? Post
  puts "Запись #{result.class.name}, id = #{options[:id]}"

  result.to_strings.each { |line| puts line }
else #показываем таблицу результатов
  print "| id\t| @type\t|   @created_at\t\t\t|   @text \t\t\t|  @url\t\t| @due_date \t "

  result.each do |row|
    puts

    row.each do |element|
      print "| #{element.to_s.delete("\\n\\r")[0..40]}\t"
    end
  end
end

puts
