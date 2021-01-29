class AdminController < ApplicationController
    include JobsitesHelper
    
    layout "admin_sections"
    before_action :admin_required

    def index
    end
end