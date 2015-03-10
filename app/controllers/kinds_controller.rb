class KindsController < ApplicationController
  before_action :set_kind, only: [:show, :edit, :update, :destroy]

  def index
    @kinds = Kind.all
  end

  def show
  end

  def create
    @kind = Kind.new(kind_params)

    if @kind.save
      head :ok
    else
      render json: @kind.errors.messages, status: :unprocessable_entity
    end
  end

  def update
    if @kind.update(kind_params)
      render :show, status: :ok
    else
      render json: @kind.errors.messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @kind.destroy
      head :no_content
    else
      render json: { errors: @kind.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def set_kind
    @kind = Kind.find(params[:id])
  end

  def kind_params
    params.require(:kind).permit(:name)
  end
end
