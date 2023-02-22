class ProductionsController < ApplicationController
    def index
        #to_json
        #productions = Production.all
        render json: Production.all, status: :ok
    end 
    def show
         
        render json: Production.find(params[:id]), status: :ok
    end 
end
