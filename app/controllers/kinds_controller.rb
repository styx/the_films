class KindsController < ApplicationController
  before_action :set_kind, only: [:show, :edit, :update, :destroy]

  def index
    @kinds = Kind.all
  end

  def show
  end

  def new
    @kind = Kind.new
  end

  def edit
  end

  def create
    @kind = Kind.new(kind_params)

    respond_to do |format|
      if @kind.save
        format.html { redirect_to @kind, notice: 'Kind was successfully created.' }
        format.json { render :show, status: :created, location: @kind }
      else
        format.html { render :new }
        format.json { render json: @kind.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @kind.update(kind_params)
        format.html { redirect_to @kind, notice: 'Kind was successfully updated.' }
        format.json { render :show, status: :ok, location: @kind }
      else
        format.html { render :edit }
        format.json { render json: @kind.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @kind.destroy
    respond_to do |format|
      format.html { redirect_to kinds_url, notice: 'Kind was successfully destroyed.' }
      format.json { head :no_content }
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
