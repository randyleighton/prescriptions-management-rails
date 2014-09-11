class PrescriptionsController < ApplicationController

  def index
    @prescriptions = Prescription.all
    @drugs = Drug.all
  end

  def new
    @prescription = Prescription.new
  end

  def create
    # @prescription = @prescription.drugs.new
    @prescription = Prescription.new(params[:prescription])
    if @prescription.save
      flash[:notice] = "Created Successfully."
      redirect_to prescriptions_path
    else
      render 'new'
    end
  end

  def show
    @prescription = Prescription.find([:id])
  end

  def destroy
    @prescription = Prescription.find([:id])
    @prescription.destroy
    flash[:notice] = "Removed Successfully."
    redirect_to prescriptions_path
  end

end
