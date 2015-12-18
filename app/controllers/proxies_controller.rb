class ProxiesController < ApplicationController
  before_action :set_proxy, only: [:show, :edit, :update, :destroy]
  require 'net/http'
  require 'net/ping'
  # GET /proxies
  # GET /proxies.json
  def index
    @proxies = Proxy.all
  end

  # GET /proxies/1
  # GET /proxies/1.json
  def show
  end

  # GET /proxies/new
  def new
    @proxy = Proxy.new
  end

  # GET /proxies/1/edit
  def edit
  end

  # POST /proxies
  # POST /proxies.json
  def create
    @proxy = Proxy.new(proxy_params)

    respond_to do |format|
      if @proxy.save
        format.html { redirect_to @proxy, notice: 'Proxy was successfully created.' }
        format.json { render action: 'show', status: :created, location: @proxy }
      else
        format.html { render action: 'new' }
        format.json { render json: @proxy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proxies/1
  # PATCH/PUT /proxies/1.json
  def update
    respond_to do |format|
      if @proxy.update(proxy_params)
        format.html { redirect_to @proxy, notice: 'Proxy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @proxy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proxies/1
  # DELETE /proxies/1.json
  def destroy
    @proxy.destroy
    respond_to do |format|
      format.html { redirect_to proxies_url }
      format.json { head :no_content }
    end
  end

  def proxy_load
    f = File.new("/home/glafir/RoR/fips/app/controllers/proxy.txt")
    @a = Array.new
    while line = f.gets
      line = line.split(/:/)
      @proxy = Proxy.new(:proxy_address => line[0], :proxy_port => line[1])
      @proxy.save
      @a.push(line)
    end
    f.close
  end

  def proxy_check
#    @
    @proxies = Proxy.where(proxy_status: nil)
    url = "ya.ru"
    @proxies.each do |p|
      proxy = Net::Ping::TCP.new(p.proxy_address, p.proxy_port.to_i)
      if proxy.ping?
        @resp = Curl::Easy.new(url) { |easy|
          easy.proxy_url = p.proxy_address
          easy.proxy_port=p.proxy_port.to_i
#          easy.timeout=90
#          easy.connect_timeout=30
#          easy.follow_location = true
#          easy.proxy_tunnel = true
        }
        begin
        @resp.perform
        @resp.response_code
        if @resp.response_code.to_i == 200
          p.proxy_status = 1
          p.proxy_timeout = @resp.total_time
        else
            p.proxy_status = 0
            p.proxy_timeout = nil
            puts "CURL_GET  fail "+p.proxy_address
          end
          rescue
          puts "CURL_GET  fail "+p.proxy_address
          p.proxy_status = 0
          p.proxy_timeout = nil
        end
      else
        p.proxy_status = 0
        p.proxy_timeout = nil
        puts "ping fail "+p.proxy_address
      end
      p.save
    end
  end

  def fips_kachalka
  100.times {
    puts Time.now
    @proxies = Proxy.where(proxy_status: nil).group("proxy_address")
    @proxies.each do |proxy|
      @fips = FipsTz.find_by(doc: nil)
      @fips.doc = "working"
      @fips.save
      begin
        @doc = Nokogiri::HTML(open(@fips.url_string_fips.to_s, :read_timeout => 180, :proxy => "http://"+proxy.proxy_address.to_s+":"+proxy.proxy_port.to_s))
        @fips.doc = @doc.css('body').to_s.encode("utf-8")
        if @doc.css('title').to_s.encode("utf-8").scan(/[А-я]/) == ["О", "ш", "и", "б", "к", "а"]
         @fips.doc = nil
         @fips.save
         proxy.proxy_status = 2
         proxy.save
         puts "TM #{@fips.tz_n} is BANNED BY FIPS via #{proxy.proxy_address.to_s}:#{proxy.proxy_port.to_s}"
       elsif @doc.css('title').to_s.encode("utf-8").include? "Leroy Merlin"
         @fips.doc = nil
         @fips.save
         proxy.proxy_status = 0
         proxy.save
         puts "TM #{@fips.tz_n} is DENIED BY GUARDIAN #{proxy.proxy_address.to_s}:#{proxy.proxy_port.to_s}"
       elsif @doc.css('title').to_s.encode("utf-8").include? "Denied"
         @fips.doc = nil
         @fips.save
#         proxy.proxy_status = 0
#         proxy.save
         puts "TM #{@fips.tz_n} is DENIED BY GUARDIAN #{proxy.proxy_address.to_s}:#{proxy.proxy_port.to_s}"
       elsif @doc.css('title').to_s.encode("utf-8").include? "DansGuardian"
         @fips.doc = nil
         @fips.save
#         proxy.proxy_status = 0
#         proxy.save
         puts "TM #{@fips.tz_n} is DENIED BY GUARDIAN #{proxy.proxy_address.to_s}:#{proxy.proxy_port.to_s}"
       elsif @doc.css('body') == ' ' or @doc.css('body') == ''
         @fips.doc = nil
         @fips.save
         proxy.proxy_status = 0
         proxy.save
         puts "TM #{@fips.tz_n} is EMPTY via #{proxy.proxy_address.to_s}:#{proxy.proxy_port.to_s}"
       else
          if @fips.save
            proxy.proxy_status = 1
            proxy.save
            puts "TM #{@fips.tz_n} is loaded via #{proxy.proxy_address.to_s}:#{proxy.proxy_port.to_s}"
          end
        end
     rescue
        proxy.proxy_status = 0
        proxy.save
        @fips.doc = nil     
        @fips.save
        puts "CURL FAILED via #{proxy.proxy_address.to_s}:#{proxy.proxy_port.to_s}"
      end
    end
    puts "sleeping for 5 minutes..."
    sleep(30)
    }
  end

  def check

    @doc = Nokogiri::HTML(open("http://xxx.org", :proxy =>"http://168.243.48.106:8080"))
    @resp = @doc.css('title').to_s.encode("utf-8").include? "DansGuardian"

#        @resp = Curl::Easy.new("http://119.31.123.207:8000/http://ya.ru") { |easy|
#          easy.proxy_url = "118.175.9.242"
#          easy.proxy_port = 8080
#          easy.timeout=90
#          easy.connect_timeout=30
#          easy.follow_location = true
#          easy.proxy_tunnel = true
#        }
#      @resp.perform
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proxy
      @proxy = Proxy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def proxy_params
      params.require(:proxy).permit(:proxy_address, :proxy_status, :proxy_timeout)
  end
end
