class Admin::EmployeesController < ApplicationController
    include JobsitesHelper

    layout "admin", only: [:site_crews]
    layout "admin_sections"
    before_action :admin_required
    before_action :set_admin_variables

    def index
    end

    def site_crews
    end

    def search

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
        params.require(:employees).permit(:id, :first_name, :last_name, :title_id, :search, titles_attributes:  [:id, :title])
    end

    def set_admin_variables
        @employees = Employee.all
        case view_by
        when 'index','site_crews','search'
            if params[:search]
                @employees = Employee.search(params[:search])
            end
            @jobsites = Jobsite.large_to_small
        when 'edit'
            @employee = Employee.find_by(id: params[:id])
        when 'new'
            @employee = Employee.new
        end
    end

end
