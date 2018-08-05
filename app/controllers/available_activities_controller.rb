class AvailableActivitiesController < ApplicationController
  before_action :set_available_activity, only: [:show, :update, :destroy]
  before_action :permit_params, only: [:filters]

  # GET /available_activities
  def index
    @available_activities = AvailableActivity.all

    render json: @available_activities
  end

  def filters
    @available_activities = AvailableActivity.filter_with(permit_params)

    render json: @available_activities, status: 200
  end

  # GET /available_activities/1
  def show
    render json: @available_activity
  end

  # POST /available_activities
  def create
    @available_activity = AvailableActivity.new(available_activity_params)

    if @available_activity.save
      render json: @available_activity, status: :created, location: @available_activity
    else
      render json: @available_activity.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /available_activities/1
  def update
    if @available_activity.update(available_activity_params)
      render json: @available_activity
    else
      render json: @available_activity.errors, status: :unprocessable_entity
    end
  end

  # DELETE /available_activities/1
  def destroy
    @available_activity.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_available_activity
      @available_activity = AvailableActivity.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def available_activity_params
      # params.require(:available_activity).permit(:type,:geometry,:properties)
       whitelisted = ActionController::Parameters.new({
              type: params.require(:available_activity)[:type],
              geometry: params.require(:available_activity)[:geometry].try(:permit!).to_h,
              properties: params.require(:available_activity)[:properties].try(:permit!).to_h
          }).try(:permit!)
    end

    def permit_params
      params.permit(:opening_hours, :category, :location, :district)
    end
end
