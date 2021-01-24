class JobsiteEmployeesController < ApplicationController
    include JobsitesHelper
    before_action :current_jobsite

    def new
    end

    def create
        employee = Employee.find(params[:employee][:id])

        if @jobsite.employees.include?(employee)    
            flash[:alert] = "#{employee.full_name} is already part of the Crew." 
        else
            @jobsite.employees << employee
        end
        redirect_to jobsite_employees_path(@jobsite)
    end

    def destroy
        remove = JobsiteEmployee.find_by(jobsite_id:params[:jobsite_id], employee_id:params[:id])
            remove.destroy unless remove.nil?
            redirect_to jobsite_employees_path(@jobsite)
    end
    
end
