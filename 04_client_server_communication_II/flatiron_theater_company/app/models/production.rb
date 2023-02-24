class Production < ApplicationRecord
    validates_presence_of :title, :budget, :director, :description, :image, :genre
    validates :title, length: {maximum:50}
    validates :description, length:{in: 5...250}
    validates :budget, numericality: {greater_than:0, message:"$$$$More Money Plzzz$$$$$$"}
    validates :image, format: {with:%r{.(jpg|png)\Z}i, message:"The file type must be a jpg or png"  }
    
    validate :genre, :no_more_musicals

    def no_more_musicals
        
        # If we are making a Musical
        # And if there are Musicals that are currently ongoing 
        if self.genre == "Musical" && Production.where(genre:'Musical',ongoing:true).count > 0
            errors.add :genre, "Sorry no more Musicals"
        end 
    end 
end
