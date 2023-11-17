class RoomTypesController < ApplicationController
  before_action :set_room_type, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[ create update destroy ]
  before_action :authorize_user, only: %i[ create update destroy ]

  # GET /room_types
  def index
    @room_types = RoomType.all

    render json: @room_types
  end

  # GET /room_types/1
  def show
    render json: @room_type
  end

  # POST /room_types
  def create
    @room_type = current_user.room_types.new(room_type_params)

    if @room_type.save
      render json: @room_type, status: :created, location: @room_type
    else
      render json: @room_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /room_types/1
  def update
    if @room_type.update(room_type_params)
      render json: @room_type
    else
      render json: @room_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /room_types/1
  def destroy
    @room_type.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_room_type
    @room_type = RoomType.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def room_type_params
    params.require(:room_type).permit(:name, :description, :max_adult, :max_kids, :price_per_night, :available_rooms)
  end

  # Only admin can add/update/delete room type
  def authorize_user
    error_response 'Only admins can add/update/delete room type' unless current_user.admin?
  end
end
