class ApplicationsController < ApplicationController
  before_action :set_application, only: %i[show update]
  skip_before_action :verify_authenticity_token

  # GET /applications
  def index
    @applications = Application.all
    render json: @applications.to_json(except: :id)
  end

  # GET /applications/token
  def show
    render json: @application.to_json(except: :id)
  end

  # POST /applications
  def create
    @application = Application.new(application_params)

    if @application.save
      render json: @application.to_json(except: :id)
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /applications/token
  def update
    if @application.update(application_params)
      render json: @application.to_json(except: :id)
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  private

  def set_application
    @application = Application.find_by(token: params[:token])
  end

  def application_params
    params.require(:application).permit(:name)
  end
end
