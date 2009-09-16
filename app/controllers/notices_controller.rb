class NoticesController < ApplicationController
  def index
    notice = Notice.create_from_yaml(request.raw_post)
    notice.save!

    render :text => "Successfully received error from hoptoad_notifier!"
  end

end
