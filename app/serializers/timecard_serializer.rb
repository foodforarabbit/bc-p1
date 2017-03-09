class TimecardSerializer < ActiveModel::Serializer
  attributes :id, :username, :occurrence, :total_hours

  has_many :time_entries
end