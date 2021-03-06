class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :update, :destroy]

  # GET /tickets
  def index
    @tickets = Ticket.all
    render json: @tickets
  end

  # GET /tickets/1
  def show
    @ticket = Ticket.where(
      id: params[:id]
    ).or(
      Ticket.where(
        original_ticket_id: params[:id]
      ))
   
    render json: @ticket
  end

  # POST /tickets
  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      render json: @ticket, status: :created, location: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tickets/1
  def update
    if @ticket.update(ticket_params)
      if @ticket.give_flg == 1
        @ticket.give_flg = '2'
        @ticket.save
        Ticket.create(ticket_name: @ticket.ticket_name, user_id: @ticket.give_user_id, give_flg:3, original_ticket_id: @ticket.id)
      end
      @ticket = Ticket.where(
          id: params[:id]
        ).or(
          Ticket.where(
            original_ticket_id: params[:id]
          ))
        
      render json: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tickets/1
  def destroy
    @ticket.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ticket_params
      params.fetch(:tickets, {}).permit(:ticket_name, :user_id, :give_flg, :give_user_id, :original_ticket_id)
    end
end
