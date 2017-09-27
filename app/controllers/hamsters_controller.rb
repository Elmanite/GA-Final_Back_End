class HamstersController < ApplicationController
  before_action :set_hamster, only: [:update, :destroy]

  # GET /hamsters
  def index
    @hamsters = Hamster.all

    render json: @hamsters
  end

  # GET /hamsters/1
  def show
    puts 'GET_CURRENT_USER.ID = ' + get_current_user.id.to_s
    authorize_user(get_current_user.id)
    @user_hamsters = User.find(params[:id]).hamsters
    render json: @user_hamsters
  end

  # POST /hamsters
  def create
    puts '------Creating new hamster-------- '
    @hamster = Hamster.new(hamster_params)
    @hamster.user_id = params[:user_id]
    puts "---was hampster created?--------------"

    if @hamster.save
      render json: @hamster, status: :created
    else
      render json: @hamster.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hamsters/1
  def update
    puts '---- PUT /hamsters/:id update ---'
    puts 'The passed parameters are: ' + hamster_params.to_s
    puts '@hamster = ' + @hamster.to_s
    @hamster = Hamster.find(params[:id])
    if @hamster.update(hamster_params)
      render json: @hamster
    else
      render json: @hamster.errors, status: :unprocessable_entity
    end
  end

  # DELETE /hamsters/1
  def destroy
    puts "------DELETING HAMSTER--------------"
    puts @hamster.user_id
    @hamster = Hamster.find(params[:id])
    @hamster.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hamster
      @hamster = Hamster.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def hamster_params
      params.require(:hamster).permit(:name, :color, :victory_points)
    end
end
