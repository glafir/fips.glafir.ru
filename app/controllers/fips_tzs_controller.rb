class FipsTzsController < ApplicationController
  before_action :set_fips_tz, only: [ :show, :noko, :edit, :update, :destroy, :fips_show, :update_tz]
  layout "fips_app", :only => [ :fips_show]
#  protect_from_forgery except: :fips_adm
#  skip_before_action :fips_adm
  # GET /fips_tzs
  # GET /fips_tzs.json
  def index
    @fips_tzs = FipsTz.where(country: "RU")
#    @fips_tzs = @fips_tzs.search(params[:search]) unless params[:search].blank?
    @fips_tzs = @fips_tzs.search_datefinish(params[:search_datefinish]) if params[:search_datefinish] != nil
    @fips_tzs = @fips_tzs.search_tzn(params[:search_tzn]) if params[:search_tzn] != nil and params[:search_tzn] != ''
    @fips_tzs = @fips_tzs.page(params[:page]).per(30)
  end

  def fips_adm
  end

  def update_all
    i=152820
    (i...418315).each {|tz|
      @fips_tz = FipsTz.find_by(id: tz)
      if @fips_tz.blank?
        @fips_tz.id = tz
        @fips_tz.tz_n = @fips_tz.tz_n + 1
        @fips_tz.save
      else
        if @fips_tz.doc.blank?
          puts "id #{i}.doc is blank!"
        else
        date_and_time = '%d.%m.%Y'
        if Nokogiri::HTML::Document.parse(@fips_tz.doc).css('b')[6].blank? || Nokogiri::HTML::Document.parse(@fips_tz.doc).css("td[class=s2]").blank? || Nokogiri::HTML::Document.parse(@fips_tz.doc).css("td[class=s1]").blank?
          @fips_tz.doc = nil
          @fips_tz.status = 0
          @fips_tz.save
        else
          @fips_tz.country = Nokogiri::HTML::Document.parse(@fips_tz.doc).css('b')[7].text[-3...-1]
          @start_date = Nokogiri::HTML::Document.parse(@fips_tz.doc).css("td[class=s2]")[0].text.split(":")[1].to_s
          @end_date = Nokogiri::HTML::Document.parse(@fips_tz.doc).css("td[class=s1]")[2].text.split(":")[1].to_s
          @fips_tz.date_start = Date.parse(@start_date, date_and_time).to_s
          @fips_tz.date_end = Date.parse(@end_date, date_and_time).to_s
          @fips_tz.org = Nokogiri::HTML::Document.parse(@fips_tz.doc).css('b')[7].text
          @fips_tz.status = 1
          @fips_tz.save
        end
      end
    end
#    rescue ActiveRecord::RecordNotFound
#    @fips_tz.id = i
#    @fips_tz.tz_n = @fips_tz.tz_n + 1
#    @fips_tz.save
#    end
    }
  end

  # GET /fips_tzs/1
  # GET /fips_tzs/1.json
  def show
  end

  def fips_show
  end

  def noko
    date_and_time = '%d.%m.%Y'
    @fips_tz.country = Nokogiri::HTML::Document.parse(@fips_tz.doc).css('b')[8].text[-3...-1]
    @start_date = Nokogiri::HTML::Document.parse(@fips_tz.doc).css("td[class=s2]")[0].text.split(":")[1].to_s
    @end_date = Nokogiri::HTML::Document.parse(@fips_tz.doc).css("td[class=s1]")[2].text.split(":")[1].to_s
    @fips_tz.date_start = Date.parse(@start_date, date_and_time).to_s
    @fips_tz.date_end = Date.parse(@end_date, date_and_time).to_s
    @fips_tz.org = Nokogiri::HTML::Document.parse(@fips_tz.doc).css('b')[8].text
    @fips_tz.save
  end

  # GET /fips_tzs/new
  def new
    @fips_tz = FipsTz.new
  end

  def update_tz
  @fips_tz.doc =  Nokogiri::HTML(open(@fips_tz.url_string_fips.to_s)).css('body').to_s.encode("utf-8")
    respond_to do |format|
      if @fips_tz.save
        format.html { redirect_to @fips_tz, notice: 'Fips tz was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @fips_tz.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /fips_tzs/1/edit
  def edit
  end

  # POST /fips_tzs
  # POST /fips_tzs.json
  def create
    @fips_tz = FipsTz.new(fips_tz_params)
    respond_to do |format|
      if @fips_tz.save
        format.html { redirect_to @fips_tz, notice: 'Fips tz was successfully created.' }
        format.json { render action: 'show', status: :created, location: @fips_tz }
      else
        format.html { render action: 'new' }
        format.json { render json: @fips_tz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fips_tzs/1
  # PATCH/PUT /fips_tzs/1.json
  def update
    respond_to do |format|
      if @fips_tz.update(fips_tz_params)
        format.html { redirect_to @fips_tz, notice: 'Fips tz was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @fips_tz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fips_tzs/1
  # DELETE /fips_tzs/1.json
  def destroy
    @fips_tz.destroy
    respond_to do |format|
      format.html { redirect_to fips_tzs_url }
      format.json { head :no_content }
    end
  end

  def tz_number_generate
    if params[:tz_start] and params[:tz_end] != nil
      @tz_start = params[:tz_start].to_i
      @tz_end =  params[:tz_end].to_i
      (@tz_start...@tz_end).each do |tz|
        @fips_tz = FipsTz.find_by(tz_n: tz)
        if @fips_tz.blank?
          @fips_tz = FipsTz.new(:tz_n => tz, :url_string_fips => "http://www1.fips.ru/fips_servl/fips_servlet?DB=RUTM&rn="+rand(1000..9999).to_s+"&DocNumber="+tz.to_s+"&TypeFile=html")
          @fips_tz.save
        else
          @fips_tz.destroy
          @fips_tz = FipsTz.new(:tz_n => tz, :url_string_fips => "http://www1.fips.ru/fips_servl/fips_servlet?DB=RUTM&rn="+rand(1000..9999).to_s+"&DocNumber="+tz.to_s+"&TypeFile=html")
          @fips_tz.save
        end
      end
      redirect_to fips_tzs_url, notice: 'Fips tz '+params[:tz_start]+'_'+params[:tz_end]+'was successfully generated.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fips_tz
      @fips_tz = FipsTz.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fips_tz_params
      params.require(:fips_tz).permit(:tz_n, :url_string_fips, :doc, :org, :img, :address_for_reply, :country, :date_start, :date_end, :status)
    end
end
