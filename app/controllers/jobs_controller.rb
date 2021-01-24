class JobsController < ApplicationController
    include ApplicationHelper
    include JobsitesHelper
    
    before_action :authentication_required
    before_action :current_jobsite
    before_action :set_variables
    before_action :user_jobsites

    def index
    end

    def by_hours
        render :index
    end

    def by_employees
        render :index
    end

    def by_areas
        render :index
    end

    def new_area
        add_to_jobs = params[:area][:jobs][:id]

        if add_to_jobs.nil? 
            flash[:alert] = 'You must select at least ONE job to apply the new code to.'
            redirect_to jobsite_jobs_path(@jobsite)
        end

        area = Area.find_or_create_by(code: params[:area][:code], name:params[:area][:name])

        add_to_jobs.each do |j|
            job = Job.find(j)
            job.areas << area
        end

        if !area.save
            area.errors.full_messages.map {|err| flash[:alert] = err} unless area.errors.nil?
        end

        render :index
    end

    def edit
        render :index 
    end

    def create
        @job = Job.create(jobs_params)
        @jobsite.jobs << @job
        add_areas = params[:job][:area][:id].reject! { |x| x.empty? }

        add_areas.collect { |area| @job.areas << Area.find(area.to_i) }

        redirect_to jobsite_jobs_path(@jobsite) unless !@job.save

        @job.errors.full_messages.map {|err| flash[:alert] = err} unless @job.errors.nil?
        render :new
    end

    def update
        @job.update(name: params[:job][:name], customer: params[:job][:customer])
        add_areas = params[:job][:area][:id].reject! { |x| x.empty? }
        add_areas.collect do |area|
            a = Area.find(area)
            @job.areas << a unless @job.areas.include?(a)
        end
        redirect_to jobsite_jobs_path(@jobsite)
    end

    def remove
        @job.update(active: false)
        redirect_to jobsite_jobs_path(@jobsite)
    end

    private
    def jobs_params
        params.require(:job).permit(:id, :job_number, :name, :customer, :jobsite_id, areas_attributes:  [:code, :name, :jobs])
    end

    def set_variables
        case params[:action]
        when "new"
            @job = @jobsite.jobs.build
        when "new_area", "update","remove"
            @job = Job.find_by(id: params[:id])
        end
    end
end