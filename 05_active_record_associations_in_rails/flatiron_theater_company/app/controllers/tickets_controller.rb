class TicketsController < ApplicationController
    #Get All
    def index
        render json: Ticket.all, status: :ok
    end 
    #Get one
    def show 
        render json: Ticket.find(params[:id]), status: :ok
    end 
    
    #Create 
    def create
        ticket = Ticket.create!(ticket_params)
        render json: ticket, status: :created
    end 

    private 

    def ticket_params
        params.permit(:production_id, :user_id, :price)
    end 
end
