class CommunesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :api_not_found
  rescue_from ActionController::ParameterMissing, with: :api_bad_request

  before_action :set_commune, only: [:show, :edit, :update, :destroy]

  # GET /communes
  def index
    @communes = Commune.all
    respond_to do |format|
      format.html { render json: {}, status: :not_acceptable }
      format.json { render json: {}, status: :ok }
    end
  end

  # GET /communes/1
  def show
    render json: {}, status: :ok
  end

  # POST /communes
  def create
    render json: {}, status: :forbidden
  end

  # PATCH/PUT /communes/1
  def update
    if @commune.update(commune_params)
      render json: {}, status: :no_content
    else
      render json: {}, status: :bad_request
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_commune
    @commune = Commune.find_by(code_insee: params[:id])
    raise ActiveRecord::RecordNotFound unless @commune
  end

  # Only allow a trusted parameter "white list" through.
  def commune_params
    params.fetch(:commune).permit(:name, :code_insee)
  end

  def api_not_found
    render json: {}, status: :not_found
  end

  def api_bad_request
    render json: {}, status: :bad_request
  end
end
