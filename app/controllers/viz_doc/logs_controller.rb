module VizDoc
  class LogsController < ::ApplicationController
    def show
      @logs = VizDoc::Log.get_logs(params[:filename])
      render json: @logs
    end

    def index
      #render 'index', :layout => false
    end
  end
end
