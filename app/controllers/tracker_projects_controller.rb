class TrackerProjectsController < ApplicationController

  def show
    tracker_api = TrackerAPI.new
    @tracker_stories ||= tracker_api.stories(current_user.pivotal_token) if current_user.pivotal_token
    @project_name = tracker_api.project(current_user.pivotal_token,params[:id])[:name]
  end

end
