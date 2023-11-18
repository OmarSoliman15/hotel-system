class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show cancel ]
  before_action :authenticate_user!, only: %i[ index show create ]
  before_action :can_cancel, only: %i[ cancel ]

  # GET /reservations
  def index
    @reservations = ReservationListBuilder.new(params, current_user).ranged_list

    render json: @reservations
  end

  # GET /reservations/1
  def show
    render json: @reservation
  end

  # POST /reservations
  def create
    reservation_create = ::ReservationCreate.new(reservation_params, current_user).create

    if reservation_create[0].present?
      success_response reservation_create[1], :created
    else
      error_response reservation_create[1]
    end
  end

  # PATCH/PUT /reservations/1/cancel
  def cancel
    if @reservation.update(status: :cancelled, cancelled_at: Time.now)
      render json: @reservation
    else
      error_response @reservation.errors
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])

    error_response(errors: ['Reservation not found'], status: :not_found) unless @reservation.present?
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :number_of_adults, :number_of_kids,
                                        room_types: [:room_type_id, :number_of_rooms])
  end

  # Check if reservation is allowed to be cancelled.
  def can_cancel
    if @reservation.status.in? Reservation::FINISHED_STATUSES || !authorize_user
      error_response 'You are not allowed to do this action'
    end
  end

  # Only admin is authorized to do this action
  def authorize_user
    !current_user.admin? || @reservation.user_id == current_user.id
  end

  def success_response(object, status)
    render json: object, status: status, location: object
  end
end
