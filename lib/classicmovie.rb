module Cinema
  class ClassicMovie < Movie

    def cost
      1.5 
    end 

    def description
      format(" %s - классический фильм ( %s, - %s). Режиссер %s. Еще его фильмы(%s) ",
              @name, @year, @duratation, @director, @collection.filter( director: @director ).count )
     end
  end
end
