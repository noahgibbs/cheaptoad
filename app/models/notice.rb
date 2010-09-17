class Notice < ActiveRecord::Base
  [:session, :request, :environment, :backtrace].each {|a| serialize a}

  # Accepts a string or parsed XML
  def self.from_v2_xml(str)
    full_xml = Hash.from_xml(str) if str.kind_of? String
    self.from_hash(full_xml)
  end

  def self.from_v1_yaml(str)
    full_yaml = YAML.load(str) if str.kind_of? String
    self.from_hash(full_yaml)
  end

  # Accepts a string or parsed YAML
  def self.from_hash(full_hash)
    full_hash = full_hash['notice'] if full_hash['notice']

    if(full_hash['error']['backtrace'].kind_of? String)
      backtraces = full_hash['error']['backtrace']
    else
      backtraces = full_hash['error']['backtrace']['line']
    end
    digest = Digest::SHA1.hexdigest(backtraces.to_s)

    notices = Notice.find_all_by_backtrace_digest(digest)
    notices = notices.reject! { |i|
      i.backtrace != full_hash['error']['backtrace']['line']
    }
    if notices and notices.length > 0
      notices[0].count += 1
      return notices[0]
    end

    # Convert to old format - ugly, but it works and doesn't break
    # all the views (yet)
    notice = Notice.new

    notice.api_key = full_hash['api_key']
    notice.error_message = full_hash['error']['message']
    notice.error_class = full_hash['error']['class']

    notice.backtrace_digest = digest

    notice.session = nil
    notice.environment = full_hash['server_environment']['environment_name']
    notice.request = full_hash['request']
    notice.backtrace = backtraces

    notice.count = 1

    notice
  end

end
