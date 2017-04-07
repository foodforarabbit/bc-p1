class BioPush < ApplicationRecord
  before_save :generate_uuid
  def generate_uuid
    if self.request_id.nil? || self.request_id == ""
      self.request_id = SecureRandom.uuid
    end
  end
end
