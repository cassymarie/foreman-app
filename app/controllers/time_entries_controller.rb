class TimeEntriesController < ApplicationController
    include JobsitesHelper
    before_action :current_jobsite
    before_action :week_ending

    def index
        @sub_days = params[:work_date].nil? ? Date.today.strftime("%w").to_i : params[:work_date].to_i
        @workdate = @week_ending - @sub_days.days
    end

    private
    def week_ending
       if params[:week_ending].nil? 
            @week_ending = Date.today.beginning_of_week + 6.days
       else
            @week_ending = DateTime.parse(params[:week_ending]).to_date
       end
       
    end

end