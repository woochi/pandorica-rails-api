class QuestsController < ApiController
  before_action :set_quest, only: [:show, :update, :destroy, :validate_code]
  before_action :authenticate_user!

  # GET /quests
  def index
    # TODO: don't return completed quests
    @quests = Quest.select(:id, :name, :description, :points).where(published: true).order(created_at: :desc)

    render json: @quests
  end

  # GET /quests/1
  def show
    render json: JSON::parse(@quest.to_json(only: [:id, :name, :description, :points])).merge(completed: current_user.quest_completions.exists?(quest_id: @quest.id))
  end

  # POST /quests
  def create
    @quest = Quest.new(quest_params)

    if @quest.save
      render json: @quest, status: :created, location: @quest
    else
      render json: @quest.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /quests/1
  def update
    if @quest.update(quest_params)
      render json: @quest
    else
      render json: @quest.errors, status: :unprocessable_entity
    end
  end

  # DELETE /quests/1
  def destroy
    @quest.destroy
  end

  # POST /quests/1
  def validate_code
    if @quest.code != params[:code].downcase
      render json: {errors: ['The quest code was incorrect']}, status: 400
    elsif current_user.quest_completions.exists?(quest_id: @quest.id)
      render json: {errors: ['You have already completed this quest']}, status: 400
    else
      current_user.quests << @quest
      current_user.increment!(:points, @quest.points)
      current_user.faction.increment!(:points, @quest.points)

      render json: @quest, status: :ok
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quest
      @quest = Quest.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def quest_params
      params.require(:quest).permit(:name, :description, :published, :points)
    end
end
