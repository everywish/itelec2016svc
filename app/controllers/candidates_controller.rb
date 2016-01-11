class CandidatesController < ApplicationController
  before_action :set_candidate, only: [:show, :edit, :update, :destroy]

  # GET /candidates
  # GET /candidates.json
  def index
    @last_crawled = History.order("created_at").last

    # 한시간마다.
    if @last_crawled.nil? or (Time.now - @last_crawled.created_at) > 3600
      @res = `bundle exec ruby ./lib/crawl/crawler/candi_list.rb`
      @history = History.new(:rawdata=>@res)
      @history.save

      JSON.parse(@res).each do |r|
        r['necid'] = r['id']
        r['id'] = nil
        candidate = Candidate.find_by(necid: r['necid'])
        candidate = Candidate.new(r) if @candidate.nil?
        candidate.save
      end
    end
    @candidates = Candidate.all
  end

  # GET /candidates/1
  # GET /candidates/1.json
  def show
  end

  # GET /candidates/new
  def new
    @candidate = Candidate.new
    redirect_to '/candidates'
  end

  # GET /candidates/1/edit
  def edit
    redirect_to '/candidates'
  end

  # POST /candidates
  # POST /candidates.json
  def create
    redirect_to '/candidates'
    return
    @candidate = Candidate.new(candidate_params)

    respond_to do |format|
      if @candidate.save
        format.html { redirect_to @candidate, notice: 'Candidate was successfully created.' }
        format.json { render :show, status: :created, location: @candidate }
      else
        format.html { render :new }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /candidates/1
  # PATCH/PUT /candidates/1.json
  def update
    redirect_to '/candidates'
    return
    respond_to do |format|
      if @candidate.update(candidate_params)
        format.html { redirect_to @candidate, notice: 'Candidate was successfully updated.' }
        format.json { render :show, status: :ok, location: @candidate }
      else
        format.html { render :edit }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /candidates/1
  # DELETE /candidates/1.json
  def destroy
    redirect_to '/candidates'
    return
    #@candidate.destroy
    #respond_to do |format|
      #format.html { redirect_to candidates_url, notice: 'Candidate was successfully destroyed.' }
      #format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate
      @candidate = Candidate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def candidate_params
      params.require(:candidate).permit(:necid, :city, :district, :party, :picture, :name, :gender, :age, :address, :occupation, :education, :career, :criminal_record)
    end
end
