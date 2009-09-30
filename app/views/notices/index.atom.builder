atom_feed do |feed|
  feed.title("Error Feed from CheapToad")
  feed.updated(@notices.first.created_at)

  @notices.each do |notice|
    feed.entry(notice) do |entry|
      entry.title(notice.error_message)
      entry.content("<p> Fake Content Here </p>\n",
                    :type => 'html')
    end
  end
end
