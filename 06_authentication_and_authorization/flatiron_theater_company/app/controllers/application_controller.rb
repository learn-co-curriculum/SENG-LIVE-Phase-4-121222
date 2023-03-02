class ApplicationController < ActionController::API
    include ActionController::Cookies
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    before_action :authorized_user

    def current_user
        user = User.find_by(id:session[:user_id])
        user
    end 

    def authorized_user
        render json: {error: "Not Authorized"}, status: :unauthorized unless current_user
        #if !current_user
        # -> send error 
    end 

    def render_unprocessable_entity(invalid)
        render json: {errors: invalid.record.errors}, status: :unprocessable_entity
    end 

     def render_not_found(error)
        #confiure the response to work with the error handleng we have on the frontend. 
        render json: {errors: {error.model => "Not Found"}}, status: :not_found
    end 
end
