class TasksController < ApplicationController
  include TasksSupport

  before_action :authenticate_user!
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @tab_status = set_tab_status
    @tasks = tasks_by_tab_status

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update('tasks-container', partial: 'tasks_container', locals: { tasks: @tasks, tab_status: @tab_status }),
          turbo_stream.update('nav-pills', partial: 'nav_pills', locals: { tab_status: @tab_status })
        ]
      end
    end
  end

  # GET /tasks/1 or /tasks/1.json
  def show
    redirect_to tasks_path if @task.nil?
  end

  # GET /tasks/new
  def new
    @task = current_user.tasks.build
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated.", params: [tab_status: params[:tab_status]] }
        format.json { render :show, status: :ok, location: @task }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("tasks-container", partial: "tasks_container", locals: { tasks: tasks_by_tab_status, tab_status: params[:tab_status] }),  notice: "Task was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
      format.turbo_stream
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      begin
        @task = current_user.tasks.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        @task = nil
        redirect_to tasks_path, alert: 'You are not authorized to view this task.'
      end
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :due_date, :status, :tab_status)
    end
end
