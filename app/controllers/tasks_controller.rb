class TasksController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @user = User.find(current_user.id)
        @tasks = Task.all
        #@user.tasks
    end
    
    def new
        @user = User.find(current_user.id)
        @task = Task.new
    end
    
    def create
        @user = User.find(current_user)
        @task = Task.create(task_params)
        if @task.save
          @task.assignments.create(user: @user)
          flash[:success] = "Task created!"
          redirect_to tasks_path
        else
          render action: :new
        end
    end
    
    def update
      @user_options = User.all.map{|u| [ u.email, u.id ] }
      
      @task = Task.find( params[:id] )
      
      if (@task.update_attributes(task_params))
        
        flash[:success] = "Task Updated!"
        redirect_to task_path(@task)
      else
        render action: :edit
      end
    end
    
    def edit
      @user_options = User.all.map{|u| [ u.email, u.id ] }
      
      @task = Task.find( params[:id] )
      
      @assignersList = Set.new
      @task.assignments.each do |ass|
        @assignersList << ass.user
      end
      
      @fellowersList = Set.new
      @task.fellowships.each do |fell|
        @fellowersList << fell.user
      end
    end
    
    def show
      @user_options = User.all.map{|u| [ u.email, u.id ] }
      @task = Task.find(params[:id])
         
      @assignersList = Set.new
      @task.assignments.each do |ass|
        @assignersList << ass.user
      end
      
      @fellowersList = Set.new
      @task.fellowships.each do |fell|
        @fellowersList << fell.user
      end
      
    end
    
    def destroy
      @task = Task.find(params[:id])
      if @task.destroy
        flash[:success] = "Task deleted!"
        redirect_to tasks_path
      else
        flash[:error] = "Task could not be deleted!"
        redirect_to edit_task_path(params[:id])
      end
    end
    
    private
    def task_params
      params.require(:task).permit(:title, :description)
    end
end
