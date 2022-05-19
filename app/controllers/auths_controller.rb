class AuthsController < ApplicationController
  def create
    hmac_secret = 'my$ecretK3y'
    
    payload = { data: params[:name] }

    token = JWT.encode payload, hmac_secret, 'HS256'
    

    render json: {token: token }
  end
end
