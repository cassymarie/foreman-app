class Admin::EmployeesController < ApplicationController
    include JobsitesHelper
    layout "admin"
    before_action :admin_required
    before_action :set_admin_variables

    def index
    end

    def new
    end

    def edit
    end

    def update
    end

    def destroy
    end


   private
    def employees_params
        params.require(:employees).permit(:id, :first_name, :last_name, :title_id)
    end

    def set_admin_variables
        case view_by
        when 'index'
            @jobsites = Jobsite.large_to_small
            @employees = Employee.all
        when 'edit'
            @employee = Employee.find_by(id: params[:id])
        when 'new'
            @employee = Employee.new
        end
    end

end
