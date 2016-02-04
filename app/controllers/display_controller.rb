class DisplayController < ApplicationController
  def index
  end

  def crawl
    @last_crawled = History.order("created_at").last

    # 한시간마다.
    if true #@last_crawled.nil? or (Time.now - @last_crawled.created_at) > 3600
      @res = `bundle exec ruby ./lib/crawl/crawler/candi_list.rb`
      @history = History.new(:rawdata=>@res)
      @history.save

      JSON.parse(@res).each do |r|
        r['necid'] = r.delete('id')
        Rails.logger.debug r
        @candidate = Candidate.find_or_initialize_by(necid: r['necid'])
        @candidate.update_attributes(r)
        if @candidate.changed?
          @candidate.save!
        end
      end
    end
    @candidates = Candidate.all
  end
end
