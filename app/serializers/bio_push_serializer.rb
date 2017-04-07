class BioPushSerializer < ActiveModel::Serializer
  attributes :id, :request_id, :confirmed_at
end