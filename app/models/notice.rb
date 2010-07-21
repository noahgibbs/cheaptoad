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

    if(full_hash['backtrace'].kind_of? String)
      backtraces = full_hash['backtrace']
    else
      backtraces = full_hash['backtrace'].join('\n')
    end
    digest = Digest::SHA1.hexdigest(backtraces)

    notices = Notice.find_all_by_backtrace_digest(digest)
    notices = notices.reject! { |i| i.backtrace != full_hash['backtrace'] }
    if notices and notices.length > 0
      notices[0].count += 1
      return notices[0]
    end

    notice = Notice.create(full_hash)
    notice.backtrace_digest = digest
    notice.count = 1

    notice
  end

end
