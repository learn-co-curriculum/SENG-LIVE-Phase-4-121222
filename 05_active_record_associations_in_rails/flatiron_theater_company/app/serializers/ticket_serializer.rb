class TicketSerializer < ActiveModel::Serializer
  attributes :id, :price
  belongs_to :production
  belongs_to :user
end
