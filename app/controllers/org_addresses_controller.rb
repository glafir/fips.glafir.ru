class OrgAddressesController < ApplicationController
  before_action :set_org_address, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @org_addresses = OrgAddress.all
    respond_with(@org_addresses)
  end

  def show
    respond_with(@org_address)
  end

  def new
    @org_address = OrgAddress.new
    respond_with(@org_address)
  end

  def edit
  end

  def create
    @org_address = OrgAddress.new(org_address_params)
    @org_address.save
    respond_with(@org_address)
  end

  def update
    @org_address.update(org_address_params)
    respond_with(@org_address)
  end

  def destroy
    @org_address.destroy
    respond_with(@org_address)
  end

  private
    def set_org_address
      @org_address = OrgAddress.find(params[:id])
    end

    def org_address_params
      params.require(:org_address).permit(:org_id, :address)
    end
end
