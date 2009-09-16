class Notice < ActiveRecord::Base
  def self.create_from_yaml(str)
    full_yaml = YAML.load(str) if str.kind_of? String
    full_yaml = full_yaml['notice'] if full_yaml['notice']

    notice = Notice.create
    notice.api_key = full_yaml['api_key']
    notice.error_message = full_yaml['error_message']
    notice.error_class = full_yaml['error_class']

    [ :session, :request, :environment, :backtrace ].each do |field|
      mini_yaml = full_yaml[field.to_s].to_yaml
      notice.send "#{field.to_s}=", mini_yaml
    end

    notice.backtrace_digest = Digest::SHA1.hexdigest(notice.backtrace)

    notice
  end

end
