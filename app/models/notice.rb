class Notice < ActiveRecord::Base
  [:session, :request, :environment, :backtrace].each {|a| serialize a}

  def self.notice_from_yaml(str)
    full_yaml = YAML.load(str) if str.kind_of? String
    full_yaml = full_yaml['notice'] if full_yaml['notice']

    if(full_yaml['backtrace'].kind_of? String)
      backtraces = full_yaml['backtrace']
    else
      backtraces = full_yaml['backtrace'].join('\n')
    end
    digest = Digest::SHA1.hexdigest(backtraces)

    notices = Notice.find_all_by_backtrace_digest(digest)
    notices = notices.reject! { |i| i.backtrace != full_yaml['backtrace'] }
    if notices and notices.length > 0
      notices[0].count += 1
      return notices[0]
    end

    notice = Notice.create(full_yaml)
    notice.backtrace_digest = digest
    notice.count = 1

    notice
  end

end
