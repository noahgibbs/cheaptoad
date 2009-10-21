atom_feed do |feed|
  feed.title(@feedtitle || "Error Feed from CheapToad")
  feed.updated(@notices.first.created_at)

  @notices.each do |notice|
    feed.entry(notice) do |entry|
      entry.title(notice.error_message)
      entry.content(<<END
<b>Project/APIkey:</b> #{notice.api_key} <br/>

<b>Error location:</b> #{notice.backtrace[0]}

<b>Request:</b> #{simple_format notice.request.to_yaml}
END
                    , :type => 'html')
    end
  end
end
