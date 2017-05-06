module Cinema
  class AncientMovie < Movie
    
    def cost
      1 
    end 

    def description
     " #{ @name } - старый фильм ( #{ @year }, - #{ @duratation }). "
    end
  end
end
