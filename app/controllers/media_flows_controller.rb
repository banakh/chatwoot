class MediaFlowsController < ApplicationController
  before_action :set_media_flow, only: %i[ show edit update destroy ]

  # GET /media_flows or /media_flows.json
  def index
    @media_flows = MediaFlow.all
  end

  # GET /media_flows/1 or /media_flows/1.json
  def show
  end

  # GET /media_flows/new
  def new
    @media_flow = MediaFlow.new
  end

  # GET /media_flows/1/edit
  def edit
  end

  # POST /media_flows or /media_flows.json
  def create
    @media_flow = MediaFlow.new(media_flow_params)

    respond_to do |format|
      if @media_flow.save
        format.html { redirect_to media_flow_url(@media_flow), notice: "Media flow was successfully created." }
        format.json { render :show, status: :created, location: @media_flow }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @media_flow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /media_flows/1 or /media_flows/1.json
  def update
    respond_to do |format|
      if @media_flow.update(media_flow_params)
        format.html { redirect_to media_flow_url(@media_flow), notice: "Media flow was successfully updated." }
        format.json { render :show, status: :ok, location: @media_flow }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @media_flow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media_flows/1 or /media_flows/1.json
  def destroy
    @media_flow.destroy

    respond_to do |format|
      format.html { redirect_to media_flows_url, notice: "Media flow was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_media_flow
      @media_flow = MediaFlow.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def media_flow_params
      params.require(:media_flow).permit(:name, :phone_number, :sla, :tra, :account_id)
    end
end
