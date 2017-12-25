class OrgsController < ApplicationController
  before_action :set_org, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @orgs = Org.all
    respond_with(@orgs)
  end

  def show
    respond_with(@org)
  end

  def new
    @org = Org.new
    respond_with(@org)
  end

  def edit
  end

  def create
    @org = Org.new(org_params)
    @org.save
    respond_with(@org)
  end

  def update
    @org.update(org_params)
    respond_with(@org)
  end

  def destroy
    @org.destroy
    respond_with(@org)
  end

  private
    def set_org
      @org = Org.find(params[:id])
    end

    def org_params
      params.require(:org).permit(:shortname, :fullname, :create, :org_state_id)
    end
end
