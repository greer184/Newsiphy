namespace :sync do
  task add_feeds: [:environment] do
    Feed.all.each do |feed|
      content = Feedjira::Feed.fetch_and_parse feed.url
      content.entries.each do |entry|
        local_entry = feed.entries.where(title: entry.title).first_or_initialize
        if entry.published != nil then
	  local_entry.update_attributes(content: entry.content, author: entry.author, url: entry.url, published: entry.published)
	end
      end
    end
  end

  task remove_feeds: [:environment] do
    entries = Entry.all
    entries.order! 'published DESC'
    limit = 1
    entries.each do |entry|
      if limit <= 100
        puts limit
      else 
        Entry.find(entry.id).destroy 
        puts "destroyed"
      end
      limit += 1
    end
  end
end
