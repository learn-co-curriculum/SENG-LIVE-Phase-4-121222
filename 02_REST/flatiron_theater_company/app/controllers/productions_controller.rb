class ProductionsController < ApplicationController
  def index
    render json: Production.all, status: :ok
  end 

  def show 
    render json: Production.find(params[:id]), except:[:created_at, :updated_at], status: :ok
  end 


end
