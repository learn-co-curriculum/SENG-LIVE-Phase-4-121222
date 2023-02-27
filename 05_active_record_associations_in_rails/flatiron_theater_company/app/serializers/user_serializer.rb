class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :password, :admin

  has_many :tickets, serializer: UserTicketsSerializer 
end
