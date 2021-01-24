class EmployeesController < ApplicationController
    include ApplicationHelper
    include JobsitesHelper

    before_action :authentication_required
    before_action :user_jobsites, except: [:index, :new]
    before_action :current_jobsite
    before_action :set_variables

    def index
    end

    def edit
        binding.pry
    end

    def update
        binding.pry
    end

    def destroy
    end

    def by_hours
        render :index
    end

    def by_jobs
        render :index
    end


   private
    def employees_params
        params.require(:employees).permit(:id, :first_name, :last_name, :title_id)
    end
    def set_variables
        if params[:action] != "index"
            @employee = Employee.find_by(id: params[:id]) 
        else
            @employee =  @jobsite.employees.build
        end
    end
end
