class UserTicketsSerializer < ActiveModel::Serializer
  attributes :id, :price, :production

  def production
    object.production.title
  end 

  def price 
    "€#{sprintf('%.2f',(object.price*1.06))}"
  end 
end
