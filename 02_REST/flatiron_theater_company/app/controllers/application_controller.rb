class ApplicationController < ActionController::API
    def welcome
        render json: {cat:"rose"}, status: :ok
    end 

    def name
       render json:{greeting:"Hello #{params[:name]}"}, status: :ok 
    end 

end
