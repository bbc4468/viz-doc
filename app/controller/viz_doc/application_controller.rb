module VizDoc
  module ApplicationController
    extend ActiveSupport::Concern

    included do
      before_filter :start_vizdoc
      after_filter :redirect_vizdoc_log

      private
      def start_vizdoc
        if params[:vizdoc]
          @vizdoc_log_file = "/tmp/#{rand(5**5)}_vizdoc"
          VizDoc.logger = ActiveSupport::BufferedLogger.new(@vizdoc_log_file)
        end
      end

      def redirect_vizdoc_log
        if params[:vizdoc]
          response.body = { :filename => @vizdoc_log_file }.to_json
        end
      end
    end

  end
end
