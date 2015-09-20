class TasksController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @user = User.find(current_user)
        @tasks = @user.tasks
    end
    
    def new
        @user = User.find(current_user)
        @task = Task.new
    end
    
    def create
        @user = User.find(current_user)
        
        @task = Task.create(task_params)
        
        
        if @task.save
          @task.ownerships.create(user: @user)
          flash[:success] = "Task created!"

          redirect_to task_path(@task)
        else
          render action: :new
        end
    end
    
    def updated
    
    end
    
    def edit
        
    end
    
    def show
        @task = Task.find(params[:id])
        @ownershipsList = @task.ownerships
        
    end
    
    def destroy
    
    end
    
    private
    def task_params
      params.require(:task).permit(:title, :description)
    end
end
