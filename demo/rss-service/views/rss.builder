xml.instruct! :xml, :version => '1.0'
xml.rss :version => "2.0" do

  @posts.keys.sort.each do |channel|
    xml.channel do
      xml.title channel
      xml.description "XConf channel"
      xml.link "https://www.thoguhtworks.com"
      xml.language "en"
      @posts[channel].each do |post|
        xml.item do
          xml.version post.version
          xml.guid post.guid
          xml.title post.title
          xml.link ""
          xml.description post.body
          xml.pubDate Time.parse(post.created_at.to_s).rfc822()
        end
      end
    end
  end
end