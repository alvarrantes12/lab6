class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy ]

  def index
    @rooms = Room.all
    render json: @rooms
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
      if @room.save
        ActionCable.server.broadcast 'rooms_channel', @room
        render json: @room
      else
        format.html { render :new, status: :unprocessable_entity }
      end
  end


  private
    def room_params
      params.require(:room).permit(:name)
    end
end
