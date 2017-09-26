class HampstersController < ApplicationController
  before_action :set_hampster, only: [:update, :destroy]

  # GET /hampsters
  def index
    @hampsters = Hampster.all

    render json: @hampsters
  end

  # GET /hampsters/1
  def show

    puts 'GET_CURRENT_USER.ID = ' + get_current_user.id.to_s
    authorize_user(get_current_user.id)
    @user_hampsters = User.find(params[:id]).hampsters
    render json: @user_hampsters
  end

  # POST /hampsters
  def create
    puts 'POST /hampsters Create using ' + hampster_params.to_s
    puts 'name ' + params[:name].to_s
    puts 'color ' + params[:color].to_s
    puts 'victory_points ' + params[:victory_points].to_s
    puts 'user_id ' + get_current_user.id.to_s

    authorize_user(get_current_user.id)
    @hampster = Hampster.new(name: params[:name], color: params[:color], victory_points: params[:victory_points], user_id: get_current_user.id)

    if @hampster.save
      render json: @hampster, status: :created, location: @hampster
    else
      render json: @hampster.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hampsters/1
  def update
    puts '---- PUT /hampsters/:id update ---'
    puts 'The passed parameters are: ' + hampster_params.to_s
    puts '@hampster = ' + @hampster.to_s
    if @hampster.user_id == get_current_user.id
      if @hampster.update(hampster_params)
        render json: @hampster
      else
        render json: @hampster.errors, status: :unprocessable_entity
      end
    else
      render json: @hampster.errors, status: :unprocessable_entity
    end
  end

  # DELETE /hampsters/1
  def destroy
    # is this the owner ???
    authorize_user(get_current_user.id)

    puts 'DELETE /hampsters/id destroy ' + get_current_user.id.to_s
    puts '@hampster.user_id = ' + @hampster.user_id.to_s

    if @hampster.user_id == get_current_user.id
      @hampster.destroy
    else
      render json: {status: :unprocessable_entity}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hampster
      @hampster = Hampster.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def hampster_params
      params.require(:hampster).permit(:name, :color, :victory_points)
    end
end
