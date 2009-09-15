class NoticesController < ApplicationController
  def index
    notice = YAML.load(request.raw_post)['notice']
    logger.info "Received post: #{request.raw_post}"
    logger.info "Received notice: #{notice.inspect}"
    #error_class = notice['error_class']
    #error_message = notice['error_message']
    #backtrace = notice['back'].blank? : notice['backtrace'] : notice['back']
    #sess = notice['session']
    #envir = notice['environment']

    render :nothing => true
  end

end
