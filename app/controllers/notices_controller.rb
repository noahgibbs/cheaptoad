class NoticesController < ApplicationController
  def create
    notice = Notice.from_v1_yaml(request.raw_post)
    notice.save!

    render :text => "Successfully received error from hoptoad_notifier!"
  end

  def index
    if params[:api_key]
      @api_key = params[:api_key]
      @notices = Notice.find_all_by_api_key(@api_key,
                                            :order => "updated_at DESC")
      render :layout => "with_feed", :action => "list_notices"
    else
      # List API keys
      res = Notice.connection.execute("SELECT DISTINCT api_key FROM notices")
      @keys = res.map {|i| i["api_key"]}
      render :action => "list_by_api_key"
    end
  end

  def show
    @notice = Notice.find(params[:id])
  end

end
