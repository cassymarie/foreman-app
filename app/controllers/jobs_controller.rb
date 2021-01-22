class JobsController < ApplicationController
    #include JobsitesController

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
        binding.pry
        redirect_to new_jobsite_job(@jobsite)
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

    def create_area
        binding.pry
    end
    # post '/jobsite/:id/jobs/new/area' do
    #     new_area = Area.create(:code => params[:area][:code].upcase, :name => params[:area][:name].capitalize)
    #     @job.areas << new_area
      #     new_area.name = params[:area][:name].capitalize
    #     new_area.save
    #     redirect "/jobsite/#{@jobsite.id}/jobs/edit/#{@job.id}"
    #     # erb :'jobs/edit', :layout => :'layouts/layout_jobs'
    # end

    # post '/jobsite/:id/jobs/new' do
    #     job = Job.create(params[:job])
    #     @jobsite.jobs << job
    #     areas = params[:areas]
    #     areas.each do |a|
    #         area = Area.find(a.to_i)
    #         job.areas << area
    #     end
    #     job.save
    #     redirect "jobsite/#{@jobsite.id}/jobs/new"
    # end

    def update
    end
    # patch '/jobsite/:id/jobs/edit/:job_id' do
    #     job = Job.find(params[:job_id].to_i)
    #     job.update(params[:job])
    #     areas = params[:areas]
    #         job.areas.clear
    #         areas.each do |a|
    #             area = Area.find(a.to_i)
    #             job.areas << area
    #         end
    #     job.save
    #     redirect "jobsite/#{params[:id]}"
    # end

    def destroy
    end
    # delete '/jobsite/:id/jobs/delete/:job_id' do
    #     job = Job.find(params[:job_id])
    #     job.delete
    #     redirect "jobsite/#{params[:id]}"
    # end
    private
    def jobs_params
        params.require(:job).permit(:id, :job_number, :name, :customer, :jobsite_id, areas_attributes:  [:code, :name])
    end

    def set_variables
        @jobsite = Jobsite.find(params[:jobsite_id])
        case params[:action]
        when "new"
            @job = Job.new
            @jobsite.jobs << @job
        when "show","edit"
            @job = Job.find_by(id: params[:id])
        end
    end

end