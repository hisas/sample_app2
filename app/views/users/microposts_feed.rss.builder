xml.instruct! :xml
xml.rss do
  xml.channel do
    xml.title "#{@user.name}'s micropostposts"

    @microposts.each do |micropost|
      xml.item do
        xml.content micropost.content
        xml.created_at micropost.created_at
      end
    end
  end
end
