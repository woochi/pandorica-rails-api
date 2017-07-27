class QuestsController < ApplicationController
  before_action :set_quest, only: [:show, :update, :destroy, :validate_code]

  # GET /quests
  def index
    # TODO: don't return completed quests
    @quests = Quest.all

    render json: @quests
  end

  # GET /quests/1
  def show
    render json: @quest
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
    if @quest.code === params[:code]
      # TODO: add points to user, strict params
      render json: @quest, status: :ok
    else
      render json: nil, status: 400
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
