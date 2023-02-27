class ProductionSerializer < ActiveModel::Serializer
  attributes :id, :title, :image, :genre, :budget, :director, :description

  has_many :cast_members
  
  #has many through
  has_many :users


  def budget
    #€100000.00
    "€#{sprintf('%.2f',(object.budget*1.06))}"
  end 

 
end
