require 'csv'
# require 'ostruct'
require 'date'
require_relative '../lib/cashbox'
require_relative '../lib/movie_collection'
require_relative '../lib/movie'
require_relative '../lib/ancientmovie'
require_relative '../lib/classicmovie'
require_relative '../lib/modernmovie'
require_relative '../lib/newmovie'
require_relative '../lib/netflix/netflix'
require_relative '../lib/theatre/theatre'

MANTH = %i[Январь Февраль Март Апрель Май Июнь Июль Август Сентябрь Октябрь Ноябрь Декабрь].freeze

films = ARGV[0] || File.expand_path('../../lib/movies.txt', __FILE__)
listfilms = Cinema::MovieCollection.new(films)

puts "\t - Список всех фильмов(listfilms)"
listfilms.first(5).each { |f| puts f }
puts
puts "\t - Список фильмов.(listfilms.sortby(:year))названия первых пяти "
listfilms.sortby(:year).first(5).each { |f| puts f }
puts
puts "\t - Список актеров [6] "
print "\t ", listfilms.actors[6]
puts
puts
puts 'Cписок всех актеров'
puts listfilms.map(&:actors).flatten.sort_by { |a| a.split[-1] }.uniq.first(5)
puts
puts 'Список режиссеров'
puts listfilms.map(&:director).sort_by { |a| a.split[-1] }.uniq.first(5)
puts
puts "Фильмы снятые не в США"
puts listfilms.reject { |m| m.country == 'USA' }.map(&:name).first(5)

puts
puts "\t - Cтатистика режиссёров:"
listfilms.stats(:director).sort.first(5).each { |k, v| puts listfilms.print_stats(k, v) }
puts
puts "\t - Cтатистика актеров:"
listfilms.stats(:actors).sort.first(5).each { |k, v| puts listfilms.print_stats(k, v) }
puts
puts "\t - Cтатистика по годам"
listfilms.stats(:year).first(5).each { |k, v| puts listfilms.print_stats(k, v) }
puts
puts "\t - Статистика по месяцам"
listfilms.stats(:month).each { |k, v| puts listfilms.print_stats(MANTH[k.to_i - 1], v) }
puts
begin
  puts "\t - Жанр фильма?"
  puts "\t listfilms.all.first.has_genre? 'Comedy' "
  puts listfilms.all.first.has_genre?('Comedy') ? "\t Yes" : "\t No"
  puts "\t listfilms.all[154].has_genre? 'Comedy'"
  puts listfilms.all[154].has_genre?('Comedy') ? "\t Yes" : "\t No"
  puts "\t listfilms.all.first.has_genre? 'Drama'"
  puts listfilms.all.first.has_genre?('Drama') ? "\t Yes" : "\t No"
  puts "\t listfilms.all[3].has_genre? 'Drama'"
  puts listfilms.all[3].has_genre?('Drama') ? "\t Yes" : "\t No"
  puts "\t Если ошиблись с жанром listfilms.all[3].has_genre? 'Boevik'"
  puts listfilms.all[3].has_genre?('Boevik') ? "\t Yes" : "\t No"
rescue RuntimeError => e
  puts "\t\t #{e.message}"
end
puts
puts "\t - Список жанров"
puts listfilms.genries
puts
puts "\t - Фильтр: listfilms.filter(year: (1945..2010),
                                    genre: /Sci-Fi|Comedy|Romance|Drama/,
                                    director: /Zemeckis Robert|Cameron James/ )"
listfilms.filter(year: (1945..2010),
                 genre: /Sci-Fi|Comedy|Romance|Drama/,
                 actors: /Johansson|Elizabeth|Julie Delpy/).first(5).each { |f| puts f }
puts
puts 'Netflix.new'
netflix = Cinema::Netflix.new(films)
netflix.pay(18)
puts 'Netflix.show'
begin
  puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :modern)
  netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic)
  netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new)
  netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :ancient)
  netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic)
  netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic)
  netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new)
  netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new)
  netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :modern)
  netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic)
  netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new)
  netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :ancient)
  netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic)
  netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic)
  netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new)
  netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new)
rescue RuntimeError => e
  puts "\t\t #{e.message}"
end
puts
netflix.pay(6)
begin
  netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic)
  netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic)
  netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new)
  netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic)
  netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic)
  netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new)
  netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new)
rescue RuntimeError => e
  puts "\t\t #{e.message}"
end
netflix.pay(1.3)
puts 'netflix.how_much?'
netflix.how_much?('Gone Girl')
netflix.how_much?('Double Indemnity')
netflix.how_much?('Persona')
netflix.how_much?('Up')
netflix.how_much?('The Great Escape')
puts
puts
theatre = Cinema::Theatre.new(films)
begin
  puts 'theatre.show(13)'
  theatre.show(13).sort_by { |f| f.rating.to_i * rand(20) }.reverse.first(4).each { |f| puts "\t #{f}" }
  puts 'theatre.show(22)'
  theatre.show(22).sort_by { |f| f.rating.to_i * rand(20) }.reverse.first(4).each { |f| puts "\t #{f}" }
  puts 'theatre.show(14)'
  theatre.show(14).sort_by { |f| f.rating.to_i * rand(20) }.reverse.first(4).each { |f| puts "\t #{f}" }
  puts 'theatre.show(2)'
  theatre.show(2).sort_by { |f| f.rating.to_i * rand(20) }.reverse.first(4).each { |f| puts "\t #{f}" }
rescue RuntimeError => e
  puts "\t\t #{e.message}"
end
puts 'theatre.when?'
theatre.when? 'Double Indemnity'
theatre.when? 'The Prestige'
theatre.when? "Who's Afraid of Virginia Woolf?"
theatre.when? 'Once Upon a Time in America'
theatre.when? "One Flew Over the Cuckoo's Nest"
theatre.when? 'The Lord of the Rings: The Return of the King'
# puts  'theatre.cash'
# puts  theatre.cash
# puts 'theatre.buy_ticket'
# theatre.buy_ticket 'Double Indemnity'
# puts 'theatre.cash'
# puts theatre.cash
# theatre.buy_ticket 'The Prestige'
# theatre.buy_ticket "Who's Afraid of Virginia Woolf?"
# puts 'theatre.cash'
# puts theatre.cash
# theatre.buy_ticket 'Once Upon a Time in America'
# puts 'theatre.cash'
# puts theatre.cash
# theatre.buy_ticket "One Flew Over the Cuckoo's Nest"
# puts 'theatre.cash'
# puts theatre.cash
# theatre.buy_ticket 'The Lord of the Rings: The Return of the King'
# puts 'theatre.cash'
# puts  theatre.cash

# begin
#   theatre.take 'money'
# rescue RuntimeError => e
#   puts "\t\t #{e.message}"
# end
# puts theatre.cash
# puts 'Netflix.cash'
# puts Cinema::Netflix.cash
# begin
#   Cinema::Netflix.take 'money'
# rescue RuntimeError => e
#   puts "\t\t #{e.message}"
# end
# puts 'theatre.cash'
# puts theatre.cash
# puts 'Netflix.cash'
# puts Cinema::Netflix.cash
# begin
#   theatre.take 'Bank'
# rescue RuntimeError => e
#   puts "\t\t #{e.message}"
# end
# puts theatre.cash
# puts Cinema::Netflix.cash
# begin
#   Cinema::Netflix.take 'Bank'
# rescue RuntimeError => e
#   puts "\t\t #{e.message}"
# end
# puts 'theatre.cash'
# puts theatre.cash
# puts 'Netflix.cash'
# puts Cinema::Netflix.cash
