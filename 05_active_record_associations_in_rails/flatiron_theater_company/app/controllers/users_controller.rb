class UsersController < ApplicationController
    def index
        render json: User.all, status: :ok
    end 
    #Get one
    def show 
        render json: User.find(params[:id]), status: :ok
    end 
end
