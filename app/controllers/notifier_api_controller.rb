class NotifierApiController < ApplicationController

  # Under Rails 2.X, matches /notifier_api/v2/notices automatically
  def v2
    notice = Notice.from_v2_xml(request.raw_post)
    notice.save!

    render :text => "Successfully received error from hoptoad_notifier v2!"
  end

end
