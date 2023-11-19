class ApplicationController < ActionController::Base

    # give access to @competitions in all views
    before_action :set_competitions
    
    def set_competitions
        @competitions = Competition.all
    end
end
