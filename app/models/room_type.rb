class RoomType < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :reservation_room_types
  has_many :reservations, through: :reservation_room_types

  # Validations
  validates_presence_of :name, :max_adult, :max_kids, :price_per_night, :available_rooms
  validates :max_adult, numericality: { only_integer: true, greater_than: 0, less_than: 10 }
  validates :max_kids, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 10 }, allow_blank: true
  validates :price_per_night, numericality: { greater_than: 0, less_than: 1000000 }
  validates :available_rooms, numericality: { greater_than: 0, less_than: 1000 }

  validate :validate_admin_creator

  # Get active reservations at specific range
  def active_reservations_on_range(start_date, end_date)
    reservations.where.not(status: Reservation::FINISHED_STATUSES)
                .where('(start_date <= :start_date OR start_date < :end_date) AND end_date >= :start_date',
                       start_date: start_date.to_date, end_date: end_date.to_date)
  end

  private

  def validate_admin_creator
    return if creator.nil?

    errors.add(:base, "Only admins can create room types") unless creator.admin?
  end
end