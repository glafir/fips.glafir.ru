class TzRequestsController < ApplicationController
  before_action :set_tz_request, only: [:show, :edit, :update, :destroy]

  # GET /tz_requests
  def index
    @tz_requests = TzRequest.all.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
    authorize @tz_requests
    respond_with @tz_requests
  end

  # GET /tz_requests/1
  def show
    authorize @tz_request
    respond_with @tz_request
  end

  # GET /tz_requests/new
  def new
    @tz_request = TzRequest.new
    authorize @tz_request
    respond_with @tz_request
  end

  # GET /tz_requests/1/edit
  def edit
    authorize @tz_request
  end

  # POST /tz_requests
  def create
    @tz_request = TzRequest.new(tz_request_params)
    authorize @tz_request
    flash[:notice] =  'The tz_request was successfully saved!' if @tz_request.save && !request.xhr?
    respond_with @tz_request
  end

  # PATCH/PUT /tz_requests/1
  def update
    @tz_request.update(tz_request_params)
    authorize @tz_request
    flash[:notice] =  'The tz_request was successfully updated!' if @tz_request.update(tz_request_params) && !request.xhr?
    respond_with @tz_request
  end

  # DELETE /tz_requests/1
  def destroy
    authorize @tz_request
    redirect_to tz_requests_url, notice: 'Tz request was successfully destroyed.'  if @tz_request.destroy && !request.xhr?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tz_request
      @tz_request = TzRequest.find(params[:id])
    end

    def sort_column
      TzRequest.all.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end


    # Only allow a trusted parameter "white list" through.
    def tz_request_params
      params.require(:tz_request).permit(:date_start, :doc, :org_id, :img)
    end
end
