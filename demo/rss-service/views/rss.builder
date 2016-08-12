xml.instruct! :xml, :version => '1.0'
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Liftoff News"
    xml.description "Liftoff to Space Exploration."
    xml.link "http://liftoff.msfc.nasa.gov/"

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.link "http://liftoff.msfc.nasa.gov/posts/#{post.id}"
        xml.description post.body
        # xml.pubDate Time.parse(post.created_at.to_s).rfc822()
        xml.guid "http://liftoff.msfc.nasa.gov/posts/#{post.id}"
      end
    end
  end
end