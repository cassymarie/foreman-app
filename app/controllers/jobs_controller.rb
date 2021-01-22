class JobsController < ApplicationController

    before_action :authentication_required
    before_action :set_variables
    before_action :user_jobsites

    # get '/abc-jobs' do
    #     @jobs = Job.where(:customer => "ABC Company LLC")
    #     erb :'jobs/customer'
    # end

    def index
       
    end

    def new
    end

    def new_area
        Area.find_or_create_by(area_params)
        #render new_jobsite_job_path(@jobsite)
        render :new
    end

    def show
    end
 
    def edit
        redirect_to new_jobsite_job unless @jobsite.jobs.size < 0 
    end

    def create
        
        @job = Job.create(jobs_params)
        @jobsite.jobs << @job
        add_areas = params[:job][:area][:id].reject! { |x| x.empty? }

        add_areas.collect do |area|
            @job.areas << Area.find(area.to_i)
        end

        if @job.save
            redirect_to jobsite_jobs_path(@jobsite)
        else
            @job.errors.full_messages.map {|err| flash[:alert] = err} unless @job.errors.nil?
            render :new
        end
    end

    def update
    end

    def destroy
    end

    private
    def jobs_params
        params.require(:job).permit(:id, :job_number, :name, :customer, :jobsite_id, areas_attributes:  [:code, :name])
    end
    def area_params
        params.require(:area).permit(:code, :name)
    end
    def set_variables
        @jobsite = Jobsite.find(params[:jobsite_id])
        case params[:action]
        when "new"
            @job = Job.new
            @jobsite.jobs << @job
        when "show","edit","new_area"
            @job = Job.find_by(id: params[:id])
        end
    end

end