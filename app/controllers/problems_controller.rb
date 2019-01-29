class ProblemsController < ApplicationController
  before_action :set_problem, only: [:show, :edit, :update, :destroy]

  # GET /problems
  # GET /problems.json
  def index
    @problems = Problem.all
  end

  # GET /problems/1
  # GET /problems/1.json

  def show
    @solutions = @problem.solution
    @criteria = @problem.criterium#.left_joins(:cridissent)
    @user = this_user
    # @dissented = []
    # @criteria.each do |criterium|
    #   @dissented << criterium.id #unless criterium.cridissent.where(user_id: @user.id).empty?
    # end
  end

  # GET /problems/new
  def new
    @problem = Problem.new
  end

  # GET /problems/1/edit
  def edit
  end

  # POST /problems
  # POST /problems.json
  def create
    @problem = Problem.new(problem_params)

    respond_to do |format|
      if @problem.save
        format.html { redirect_to issue_path(@problem), notice: 'Problem was successfully created.' }
        format.json { render :show, status: :created, location: @problem }
      else
        format.html { render :new }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /problems/1
  # PATCH/PUT /problems/1.json
  def update
    respond_to do |format|
      if @problem.update(problem_params)
        format.html { redirect_to issue_path(@problem), notice: 'Problem was successfully updated.' }
        format.json { render :show, status: :ok, location: @problem }
      else
        format.html { render :edit }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /problems/1
  # DELETE /problems/1.json
  def destroy
    @problem.destroy
    respond_to do |format|
      format.html { redirect_to problems_url, notice: 'Problem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sponsor
    @criterium = Criterium.find(params[:criterium_id])
    @user = current_user
    @dissenter = @criterium.cridissent.find_by(user_id: @user.id)
    @dissenter.destroy if @dissenter
    @criterium.user << @user unless @criterium.user.include?(@user)
    redirect_to issue_path(:problem_id => @criterium.problem_id)
  end

  def unsponsor
    @criterium = Criterium.find(params[:criterium_id])
    @user = this_user
    @criterium.user.delete(@user)
    redirect_to issue_path(:problem_id => @criterium.problem_id)
  end

  def dissent
    @criterium = Criterium.find(params[:criterium_id])
    @user = this_user
    @criterium.user.delete(@user)
    if @criterium.cridissent.where(user_id: @user.id).empty?
      @dissenter = @criterium.cridissent.new(:user_id => @user.id)
      @dissenter.save
    end
    redirect_to issue_path(:problem_id => @criterium.problem_id)
  end

  def assent
    @criterium = Criterium.find(params[:criterium_id])
    @user = this_user
    @dissenter = @criterium.cridissent.find_by(user_id: @user.id)
    @dissenter.destroy
    redirect_to issue_path(:problem_id => @criterium.problem_id)
  end

  # def add_criteria
  #   @problem = Problem.find(params[:id])

  #   render :nothing => true
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_problem
      @problem = Problem.find(params[:problem_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def problem_params
      params.require(:problem).permit(:title, :description)
    end

    # def this_user
    #   return User.find(session[:user_id])
    # end
end
