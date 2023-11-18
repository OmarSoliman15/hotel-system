class ReservationRoomType < ApplicationRecord
  belongs_to :reservation
  belongs_to :room_type

  before_save :set_price_per_night

  def set_price_per_night
    self.price_per_night = room_type.price_per_night
  end
end