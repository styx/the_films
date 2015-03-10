class GenresController < ApplicationController
  before_action :set_genre, only: [:show, :edit, :update, :destroy]
  respond_to :json

  def index
    @genres = Genre.all
  end

  def show
  end

  def create
    @genre = Genre.new(genre_params)

    if @genre.save
      head :ok
    else
      render json: @genre.errors.messages, status: :unprocessable_entity
    end
  end

  def update
    if @genre.update(genre_params)
      render :show, status: :ok
    else
      render json: @genre.errors.messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @genre.destroy
      head :no_content
    else
      render json: { errors: @genre.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name)
  end
end
