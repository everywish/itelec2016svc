class DisplayController < ApplicationController
  def index
    @last_crawled = History.order("created_at").last

    # 한시간마다.
    if @last_crawled.nil? or (Time.now - @last_crawled.created_at) > 360
      @res = `bundle exec ruby ./lib/crawl/crawler/candi_list.rb`
      @history = History.new(:rawdata=>@res)
      @history.save
    end
  end
end
