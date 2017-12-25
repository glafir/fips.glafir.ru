class OrgTelefphonesController < ApplicationController
  before_action :set_org_telefphone, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @org_telefphones = OrgTelefphone.all
    respond_with(@org_telefphones)
  end

  def show
    respond_with(@org_telefphone)
  end

  def new
    @org_telefphone = OrgTelefphone.new
    respond_with(@org_telefphone)
  end

  def edit
  end

  def create
    @org_telefphone = OrgTelefphone.new(org_telefphone_params)
    @org_telefphone.save
    respond_with(@org_telefphone)
  end

  def update
    @org_telefphone.update(org_telefphone_params)
    respond_with(@org_telefphone)
  end

  def destroy
    @org_telefphone.destroy
    respond_with(@org_telefphone)
  end

  private
    def set_org_telefphone
      @org_telefphone = OrgTelefphone.find(params[:id])
    end

    def org_telefphone_params
      params.require(:org_telefphone).permit(:org_id, :telephone)
    end
end
