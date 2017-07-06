class MoviesController < ApplicationController

  # overwirte all values in the session with those in params
  def move_params_to_session()
    params.keys().each() do 
      |key| session[key] = params[key] 
    end
  end

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.get_all_ratings()

    # if ratings are in params use them as filer, otherwise show all movies
    @movies = params[:ratings].nil?() ? Movie.where(rating: [session[:ratings].keys()]) : Movie.where(rating: [params[:ratings].keys()])

    # ordering stuff
    if params[:ordering]
      # sort movies
      @movies = @movies.order(params[:ordering])

      #css stuff
      if params[:ordering] == "title"
        @title="hilite"
      elsif params[:ordering] == "release_date"
        @date="hilite"
      end

    end

    # save settings to params
    move_params_to_session()
    puts("params\n", params[:ratings], "\nsession\n", session[:ratings])
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
