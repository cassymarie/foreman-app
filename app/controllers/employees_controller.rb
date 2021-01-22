class EmployeesController < ApplicationController
    include ApplicationHelper
    
    before_action :authentication_required
    before_action :user_jobsites, except: [:index, :new]
    before_action :set_variables

    def index
    end

    def new
    end

    def update
        binding.pry
    end

    def destroy
    end

   private
    def employees_params
        params.require(:employees).permit(:id, :first_name, :last_name, :title_id)
    end
    def set_variables
        @jobsite = Jobsite.find(params[:jobsite_id])
        
        if params[:action] != "index"
            @employee = Employee.find_by(id: params[:id]) 
        else
            @employee =  @jobsite.employees.build
        end
        #binding.pry
    end
end
