class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_token, except: [:login, :create]
  before_action :authorize_user, except: [:login, :create, :index]
  before_action :user_params, only: [:login]

  # user login
  def login
    puts '--- LOGIN ---'
    # params.each do |i|
    #   puts i
    # end
    # puts password: params[:password]
    # puts user = User.find_by(params[:username])
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])

      token = create_token(user.id, user.username)
      render json: {status: 200, token: token, user: user}
    else
      render json: {status: 401, message: "Unauthorized - Login"}
    end
  end

  # GET /users
  def index
    puts '---- GET Index /users -----'
    @users = User.all
    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    puts "-----Create new user------"
    @user = User.new(username: params[:username].to_s, password: params[:password])
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users
  def destroy
    @user.destroy
  end

  private
    def create_token(id, username)
      puts '---- CREATE TOKEN ----'
      JWT.encode(payload(id, username), ENV['JWT_SECRET'], 'HS256')
    end

    def payload(id, username)
    {
      exp: (Time.now + 30.minutes).to_i,
      iat: Time.now.to_i,
      iss: ENV['JWT_ISSUER'],
      user: {
        id: id,
        username: username
      }
    }
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      puts '--- PARAM WHITE LIST ---'
      params.require(:user).permit(:username, :password)
    end
end
