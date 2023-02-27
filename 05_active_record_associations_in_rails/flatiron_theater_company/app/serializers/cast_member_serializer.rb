class CastMemberSerializer < ActiveModel::Serializer
  attributes :id, :name, :role
  has_one :production
end
