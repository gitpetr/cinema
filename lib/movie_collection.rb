module Cinema
  class MovieCollection
    include Enumerable
    require 'money'
    Money.use_i18n = false

    attr_reader :allfilms, :genries, :period

    PERIODS = { ancient: 1900..1945, classic: 1946..1968, modern: 1969..2000, new: 2001..Time.now.year }.freeze

    def initialize(films)
      abort 'Такого файла не существует' unless File.exist?(films)

      @allfilms = CSV.read(films, col_sep: '|', headers: Movie::TITRES)
                     .map { |f| class_for(f.to_h[:year].to_i).new(self, f.to_h) }
                     .sort_by { |f| f.rating * rand(6) }.reverse

      @genries = genres
    end

    def each
      @allfilms.each { |film| yield film }
    end

    def class_for(year)
      case year
      when PERIODS[:ancient]
        AncientMovie
      when PERIODS[:classic]
        ClassicMovie
      when PERIODS[:modern]
        ModernMovie
      when PERIODS[:new]
        NewMovie
      end
    end

    def all
      @allfilms
    end

    def sortby(name)
      @allfilms.sort_by(&name)
    end

    def actors
      @allfilms.map(&:actors)
    end

    def stats(field)
      @allfilms.flat_map(&field).compact.sort.inject(Hash.new(0)) { |h, e| h[e] += 1; h }
    end

    def print_stats(k, v)
      "\t#{k.to_s.ljust(15)} #{v}"
    end

    def genres
      @genries = all.flat_map(&:genre).uniq.sort
    end

    def filter(filters)
      @allfilms.select { |f| f.match_filter?(filters) }
    end
  end
end
