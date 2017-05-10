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
      film = filter(name: filmname).first
      raise "Такого сеанса нет" unless film
      time = TIMESEANS.detect { | hours, filtres | film.match_filter?(filtres) }[0]
      puts  "Сеансы фильма: #{ film.description } идут  c #{ TIMES[time].first } по #{ TIMES[time].last }"
    end

    def buy_ticket title
      currency = Money.new(1000, "USD").currency
      cost = (when?(title))
      addtocash cost
      puts "Оплата #{Money.new( 100 * cost, "USD")}#{currency.symbol} Вы купили билет на #{title}. "
    end
  end
end
