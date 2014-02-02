xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
    xml.channel do
        xml.title "Events"
        xml.description "Current and Scheduled Events"
        xml.link events_url
        
        @events.each do |event|
            xml.item do
            
                xml.title event.title
                xml.description event.content
                
                @statuses.each do |s| 
                if event.status_id == s.id
                    @status = s.name
                end
                end
                
                xml.pubDate event.event_date.to_s(:rfc822)
                xml.category @status
                
            end
        end
    end
end