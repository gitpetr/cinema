module Cinema
  class  ModernMovie < Movie

    def cost
      2 
    end 

    def description
      format(" %s - современное кино ( %s, - %s). Играют %s .",  @name, @year, @duratation, @actors.join(', '))
    end
  end
end
