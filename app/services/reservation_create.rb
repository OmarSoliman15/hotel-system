# frozen_string_literal: true

class ReservationCreate
  attr_reader :params, :current_user
  attr_accessor :reservation

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def create
    @reservation = current_user.reservations.new(params.except(:room_types))

    validate_reservation
    @reservation.reservation_room_types.new(params[:room_types])

    if @reservation.errors.empty? && @reservation.save
      [true, @reservation]
    else
      respond_with_error
    end
  end

  private

  def validate_reservation
    available_adults = 0
    available_kids = 0

    reservation.errors.add(:base, "Reservation room type(s) can't be empty") unless params[:room_types].present?

    params[:room_types].each do |room_type|

      room_type_obj = RoomType.find_by(id: room_type["room_type_id"])

      if room_type_obj.present?
        reservation.errors.add(:base, "Room(s) availability is not matched") if
          room_type_obj.available_rooms < room_type["number_of_rooms"]

        reservation.errors.add(:base, "Room type(s) not available in this range") if
          room_type_not_available?(room_type_obj)

        available_adults += room_type_obj.max_adult * room_type["number_of_rooms"]
        available_kids += room_type_obj.max_kids * room_type["number_of_rooms"]
      else
        reservation.errors.add(:base, "Invalid room type(s)")
      end
    end

    reservation.errors.add(:base, "Extra adults capacity") if params[:number_of_adults] > available_adults
    reservation.errors.add(:base, "Extra kids capacity") if params[:number_of_kids] > available_kids
  end

  def respond_with_error
    [false, @reservation.errors]
  end

  def room_type_not_available?(room_type)
    reservations = room_type.active_reservations_on_range(params[:start_date], params[:end_date])
    reserved_rooms = room_type.reservation_room_types.where(reservation_id: reservations.pluck(:id))
    reserved_rooms.sum(:number_of_rooms) >= room_type.available_rooms
  end
end
