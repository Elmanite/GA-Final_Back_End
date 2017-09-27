class ApplicationController < ActionController::API
  def authenticate_token
    puts "AUTHENTICATE JWT"
    render json: {status: 401, message: 'Unauthorized on authenticate_token'} unless decode_token(bearer_token)
  end
  def bearer_token
    puts "BEARER TOKEN"
    puts header = request.env["HTTP_AUTHORIZATION"]

    pattern = /^Bearer/
    puts "TOKEN WITHOUT BEARER"
    puts header.gsub(pattern, '') if header && header.match(pattern)
    header.gsub(pattern, '') if header && header.match(pattern)
  end
  def decode_token(token_input)
    puts "DECODE TOKEN, token input: #{token_input}"
    puts token = JWT.decode(token_input, ENV['JWT_SECRET'], true)
    JWT.decode(token_input, ENV['JWT_SECRET'], true)
  rescue
    render json: { status: 401, message: 'Unauthorized on decode_token'}
  end
  def get_current_user
    puts @user.user_id + "This is the user ID from get current user"
    return if !bearer_token
    decoded_jwt = decode_token(bearer_token)
    puts "======"
    puts decoded_jwt.to_s
    puts "==============="
    User.find(decoded_jwt[0]["user"]["id"])
    puts "Current user_id"
    return User
  end
  def show
    render json: get_current_user
  end
  def authorize_user
    puts "AUTHORIZE USER"
    puts "username: #{get_current_user.username}"
    puts "params: #{params[:id]}"
    render json: { status: 401, message: 'Unauthorized in authorize_user' } unless get_current_user.id == params[:id].to_i
  end
  def authorize_user(id)
    puts "AUTHORIZE USER"
    puts "user id: #{get_current_user.id}"
    puts "params: #{params[:id]}"
    render json: { status: 401, message: 'Unauthorized in authorize_user(id)' } unless get_current_user.id == id.to_i
  end
end
