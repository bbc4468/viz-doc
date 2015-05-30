module VizDoc
  class LogController < ::ApplicationController
    def show
      @log = VizDoc::Logger.get_logs(params[:filename])
      render json: @log
    end

    def index
      render :index, :layout => false
    end
  end
end
