class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.all
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    @roll = @activity.roll.first
  end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    puts "---------------------------------------------------------------------------------------------------------------------"
    puts activity_params
    activity_params["activation_minimum"]
    puts "---------------------------------------------------------------------------------------------------------------------"


    @activity = Activity.new(:title => activity_params[:title],
                            :description => activity_params[:description])


    respond_to do |format|
      if @activity.save

        @roll = Roll.new(:title => "participant",
                        :description => "participant",
                        :minimum => activity_params[:activation_minimum],
                        :maximum => activity_params[:activation_maximum],
                        :activity_id => @activity.id)

        if @roll.save
          format.html { redirect_to activator_path, notice: 'Activity was successfully created.' }
          format.json { render :show, status: :created, location: @activity }
        else
          format.html { render :new }
          format.json { render json: @activity.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def participate
    @roll = Roll.find(params[:roll_id])
    @user = current_user
    @roll.user << @user unless @roll.user.include?(@user)
    redirect_to action_path(:activity_id => @roll.activity.id)
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:activity_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:title, :description, :activation, :participants, :activation_minimum, :activation_maximum)
    end
end
