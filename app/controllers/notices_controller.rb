class NoticesController < ApplicationController
  def index
    if request.put? or request.post?
      notice = Notice.create_from_yaml(request.raw_post)
      notice.save!

      render :text => "Successfully received error from hoptoad_notifier!"
    else
      if params[:api_key]
        @api_key = params[:api_key]
        @notices = Notice.find_all_by_api_key(params[:api_key])
	render :template => "notices/list_notices"
        return
      end

      # List API keys
      res = Notice.connection.execute("SELECT DISTINCT api_key FROM notices")
      @keys = res.map {|i| i["api_key"]}
      render :template => "notices/list_by_api_key"
    end
  end

  def show
    @notice = Notice.find(params[:id])
  end

end
