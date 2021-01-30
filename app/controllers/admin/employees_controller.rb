class Admin::EmployeesController < ApplicationController
    include JobsitesHelper

    layout "admin", only: [:site_crews]
    layout "admin_sections", except: [:site_crews]
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

    def create
        @employee = Employee.create(employees_params)

        if @employee.save
            render :index
        else
            area.errors.full_messages.map {|err| flash[:notice] = err} unless area.errors.nil?
            redirect_to new_admin_employee(@employee)
        end
    end

    def edit
    end

    def update
        employee = Employee.find_by(id: params[:id])
        binding.pry
        employee.update(employees_params)
        
        redirect_to admin_employees_path
    end

    def destroy
        employee = Employee.find_by(id: params[:id])
        employee.destroy
        
        redirect_to admin_employees_path
    end

   private
    def employees_params
        params.require(:employee).permit(:id, :first_name, :last_name, :search, titles_attributes:  [:id, :title])
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
