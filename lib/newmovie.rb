module Cinema
  class NewMovie < Movie
    
    def cost
      2.5 
    end 
     
    def description
      " #{ @name } - новинка вышло #{ Time.now.year - @year } лет назад. ( #{ @year }, - #{ @duratation }). "
    end
  end
end
