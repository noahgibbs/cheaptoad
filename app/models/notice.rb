class Notice < ActiveRecord::Base
  [:session, :request, :environment, :backtrace].each {|a| serialize a}

  def self.create_from_yaml(str)
    full_yaml = YAML.load(str) if str.kind_of? String
    full_yaml = full_yaml['notice'] if full_yaml['notice']

    notice = Notice.create(full_yaml)
    if(notice.backtrace.kind_of? String)
      backtraces = notice.backtrace
    else
      backtraces = notice.backtrace.join('\n')
    end
    notice.backtrace_digest = Digest::SHA1.hexdigest(backtraces)

    notice
  end

end
