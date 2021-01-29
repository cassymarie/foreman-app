class AdminController < ApplicationController
    include JobsitesHelper
    
    layout "admin"
    before_action :admin_required

    def index
    end
end