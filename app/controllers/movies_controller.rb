class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    puts params
    if (params.has_key?(:sort_by))
      sort_by = params[:sort_by]
      @hilite = sort_by
      if(sort_by=='title') 
        @movies = Movie.order('title ASC').all
        return
      elsif(sort_by=='release_date')
        @movies = Movie.order('release_date ASC').all
        return
      end 
    end
    @movies = Movie.all
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  def welcome
    flash[:notice] = "Hi there!"
    redirect_to movies_path
  end

end
