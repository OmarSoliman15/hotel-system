# frozen_string_literal: true

class ReservationListBuilder
  attr_accessor :params

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def ranged_list
    if @current_user.admin?
      @reservations = Reservation.all
    else
      @reservations = @current_user.reservations
    end

    if params[:start_date]
      from = convert_string_to_date!(params[:start_date])
      @reservations = @reservations.where("start_date >= ?", from)
    end

    if params[:end_date]
      to = convert_string_to_date!(params[:end_date])

      @reservations = @reservations.where("end_date <= ?", to)
    end
    @reservations
  end

  private

  def convert_string_to_date!(str)
    str.to_date
  end
end
