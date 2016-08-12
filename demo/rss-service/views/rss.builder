xml.instruct! :xml, :version => '1.0'
xml.rss :version => "2.0" do

  @posts.keys.sort.each do |channel|
    xml.channel do
      xml.title channel

      @posts[channel].each do |post|
        xml.item do
          xml.version post.version
          xml.title post.title
          xml.description post.body
          xml.pubDate Time.parse(post.created_at.to_s).rfc822()
        end
      end
    end
  end
end