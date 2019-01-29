class SolutionsController < ApplicationController
  before_action :set_solution, only: [:show, :edit, :update, :destroy, :poll]

  # GET /solutions
  # GET /solutions.json
  def index
    @solutions = Solution.all
  end

  # GET /solutions/1
  # GET /solutions/1.json
  def show
    @user = this_user
    @problem = @solution.problem

    polls = @solution.poll
    @criteria = @problem.criterium
    # @polls = @problem.criterium.left_joins(:poll).where("polls.solution_id = #{@solution.id}")

    puts @criteria.first.user.to_json
  end

  # GET /solutions/new
  def new
    @user = this_user
    @solution = Solution.new(:problem_id => params[:problem_id], :user_id => @user.id)
    @problem = Problem.find(params[:problem_id])
  end

  # GET /solutions/1/edit
  def edit
  end

  # POST /solutions
  # POST /solutions.json
  def create
    @solution = Solution.new(solution_params)

    respond_to do |format|
      if @solution.save
        format.html { redirect_to solution_path(:problem_id => @solution.problem_id, :solution_id => @solution.id), notice: 'Solution was successfully created.' }
        format.json { render :show, status: :created, location: @solution }
      else
        format.html { render :new }
        format.json { render json: @solution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /solutions/1
  # PATCH/PUT /solutions/1.json
  def update
    respond_to do |format|
      if @solution.update(solution_params)
        format.html { redirect_to @solution, notice: 'Solution was successfully updated.' }
        format.json { render :show, status: :ok, location: @solution }
      else
        format.html { render :edit }
        format.json { render json: @solution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /solutions/1
  # DELETE /solutions/1.json
  def destroy
    @solution.destroy
    respond_to do |format|
      format.html { redirect_to solutions_url, notice: 'Solution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  # mark yes
  def poll
    @criterium = Criterium.find(params[:criterium_id])
    # if params[:answer] == 0 || params[:answer] == 1
    @answer = params[:answer]
    # end

    @user = this_user
    @poll = @criterium.poll.where(user_id: @user.id)
    if @poll.count > 0
      puts "yee"
      puts @poll.count > 0
      @poll.update(:answer => @answer)
    else
      puts "ohh"
      @poll = @criterium.poll.new(:user_id => @user.id, :solution_id => @solution.id, :answer => @answer)
      @poll.save
    end

    redirect_to solution_path(:solution_id => @solution.id, :problem_id => @solution.problem_id)
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_solution
      @solution = Solution.find(params[:solution_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def solution_params
      params.require(:solution).permit(:title, :description, :problem_id, :user_id)
    end
end
