module Cinema
  class Theatre < MovieCollection
    include CashBox::MovieCash
    MORNING = (9..13)
    DAY = (14..18)
    EVENING = (19..24)
    MORNING_SEANS = PERIODS[:ancient]
    DAY_SEANS = /Adventure|Comedy/
    EVENING_SEANS = /Drama|Horror/
    FILTERDAY = { genre: DAY_SEANS }
    FILTEREVENING = { genre: EVENING_SEANS }
    FILTERMORNING =  { year: PERIODS[:ancient]  }
    TIMES = {
      morning: MORNING,
      day: DAY,
      evening: EVENING
    }

    FILTRES = {
      morning: FILTERMORNING,
      day: FILTERDAY,
      evening: FILTEREVENING
    }

    TIMESEANS = {
      morning: { period: :ancient },
      day: { genre: /Adventure|Comedy/ },
      evening: { genre: /Drama|Horror/ }
    }

    def show(hour)
      raise "В указанное время сеансов нет \n" unless (MORNING.first..EVENING.last).cover?(hour)
      period = TIMES.detect{ |p, hours| hours.cover?(hour) }[0]
      filter(FILTRES[period]).each{ |f| f.description }
    end

    def when? filmname
      filter(name: filmname).each do |f|
        if MORNING_SEANS === f.year
          puts "Сеансы фильма: #{ f.description } идут  c #{ MORNING.first } по #{ MORNING.last } "
          return 3
        elsif  DAY_SEANS === f.genre.to_s
          puts "Сеансы фильма: #{ f.description } идут с #{ DAY.first } по #{ DAY.last } "
          return 5
        elsif EVENING_SEANS === f.genre.to_s
          puts "Сеансы фильма: #{ f.description } идут с #{ EVENING.first } по #{ EVENING.last } "
          return 10
        else
          puts "Такого сеанса в настоящее время нет"
        end
      end
    end

    def buy_ticket title
      currency = Money.new(1000, "USD").currency
      cost = (when?(title))
      addtocash cost
      puts "Оплата #{Money.new( 100 * cost, "USD")}#{currency.symbol} Вы купили билет на #{title}. "
    end
  end
end
