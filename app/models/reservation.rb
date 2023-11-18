class Reservation < ApplicationRecord
  belongs_to :user
  has_many :reservation_room_types
  has_many :room_types, through: :reservation_room_types

  FINISHED_STATUSES = [:finished, :cancelled]

  enum status: [:reserved, :confirmed, :finished, :cancelled]

  before_create :default_status
  after_save :set_total_price

  def default_status
    self.status ||= :reserved
  end

  def set_total_price
    self.total_price ||=
      reservation_room_types
        .sum( 'reservation_room_types.number_of_rooms * reservation_room_types.price_per_night')
  end
end
