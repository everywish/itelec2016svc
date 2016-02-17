class DisplayController < ApplicationController
  def index
    @last_crawled = History.order("created_at").last
    @candidates = Candidate.where(:history_id=>@last_crawled.id)
  end

  def crawl
    @last_crawled = History.order("created_at").last

    # 30분마다
    #if @last_crawled.nil? or (Time.now - @last_crawled.created_at) > 3600
    if @last_crawled.nil? or (Time.now - @last_crawled.created_at) > 1800
      @res = `bundle exec ruby ./lib/crawl/crawler/candi_list.rb`
      @history = History.new(:rawdata=>@res)
      @history.save

      JSON.parse(@res).each do |r|
        r['necid'] = r.delete('id')
        r['history_id'] = @history.id
        Rails.logger.debug r
        @candidate = Candidate.find_or_initialize_by(necid: r['necid'])
        @candidate.update_attributes(r)
        if @candidate.changed?
          @candidate.save!
        end
      end

      @last_crawled = History.order("created_at").last
    end
    @candidates = Candidate.where(:history_id=>@last_crawled.id)
  end
end
