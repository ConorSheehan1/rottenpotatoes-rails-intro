class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # @movies = Movie.all()
    @all_ratings = Movie.get_all_ratings()

    # if no boxes are unchecked, show everything
    @movies = params[:ratings].nil?() ? Movie.all() : Movie.where(rating: [params[:ratings].keys()])

    # ordering stuff
    if params[:ordering]
      # sort movies
      @movies = @movies.order(params[:ordering])

      #css stuff
      if params[:ordering] == "title"
        puts("!!title!!")
        @title="hilite"
      elsif params[:ordering] == "release_date"
        @date="hilite"
      end
    end

    # # filter movies
    # if params[:ratings]
    #   @movies = @movies.where(rating: [params[:ratings].keys()])
    # end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
