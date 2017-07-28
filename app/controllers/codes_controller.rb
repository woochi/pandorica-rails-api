class CodesController < ApiController
  before_action :set_code, only: [:show, :update, :destroy, :validate_code]
  before_action :authenticate_user!

  # GET /codes
  def index
    @codes = Code.all

    render json: @codes
  end

  # GET /codes/1
  def show
    render json: @code
  end

  # POST /codes
  def create
    @code = Code.find_by(value: params[:value])

    if @code.nil?
      render json: {errors: ['The code was incorrect']}, status: 400
    elsif current_user.code_uses.exists?(code_id: @code.id)
      render json: {errors: ['You have already used this code']}, status: 400
    else
      CodeUse.create!(code_id: @code.id, user_id: current_user.id)
      current_user.increment!(:points, 150)
      current_user.faction.increment!(:points, 150)

      render json: @code, status: :ok
    end
  end

  # PATCH/PUT /codes/1
  def update
    if @code.update(code_params)
      render json: @code
    else
      render json: @code.errors, status: :unprocessable_entity
    end
  end

  # DELETE /codes/1
  def destroy
    @code.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_code
      @code = Code.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def code_params
      params.require(:code).permit(:value)
    end
end
