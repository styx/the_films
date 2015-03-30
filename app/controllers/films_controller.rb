class FilmsController < ApplicationController
  before_action :set_film, only: [:show, :edit, :update, :destroy]

  def index
    @films = Film.page(params[:page])
  end

  def show
  end

  def new
    @film = Film.new
  end

  def create
    @genre = Genre.new(genre_params)

    if @genre.save
      head :ok
    else
      render json: @genre.errors.messages, status: :unprocessable_entity
    end
  end

  def create
    @film = Film.new(film_params.merge(gapoif: ''))

    if @film.save
      head :ok
    else
      render json: @film.errors.messages, status: :unprocessable_entity
    end
  end

  def update
    if @film.update(film_params)
      render :show, status: :ok
    else
      render json: @film.errors.messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @film.destroy
      head :no_content
    else
      render json: { errors: @film.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def set_film
    @film = Film.find(params[:id])
  end

  def film_params
    params.require(:film).permit(
      :name,
      :gapoif,
      :url,
      :kind_id
    )
  end
end
