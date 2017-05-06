module Cinema
  class Movie
    TITRES = %i[link name year country date genre duratation rating director actors].freeze
    attr_reader *TITRES

    def initialize(owner, film)
      @link = film[:link]
      @name = film[:name]
      @year = film[:year].to_i
      @country = film[:country].split(',')
      @date = film[:date]
      @genre = film[:genre].split(',')
      @duratation = film[:duratation]
      @rating = film[:rating]
      @director = film[:director].split(' ').reverse.join(' ')
      @actors = film[:actors].split(',')
      @collection = owner
    end

    def has_genre?(genre)
      raise 'Извините! Вы ошиблись, такого жанра нет' unless @collection.genries.include?(genre)
      @genre.include?(genre)
    end

    def to_s
      "#{@name}: #{@director} ( #{@year}, #{@genre.join('/')} - #{@duratation}). Рейтинг(#{@rating})."
    end

    def month
      date[5..6] if date.length == 10
    end

    def match_filter?(**filters)

      if filters[:period]
        filters[:year] = MovieCollection::PERIODS[filters[:period]]
        filters.delete(:period)
      end

      filters.all? do |k, v|
        field = self.send(k)
        field.is_a?(Array) ? field.any? { |acter| v === acter } : v === field
      end
    end

    def watch
      currency = Money.new(1000, 'USD').currency
      @collection.payment(cost)
      "Оплата просмотра фильма #{
        Money.new(100 * cost, 'USD')}#{currency.symbol},на счете осталось #{
        Money.new(100 * @collection.deposit, 'USD')}#{currency.symbol}"
    end
  end
end
