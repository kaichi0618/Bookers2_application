class SearchesController < ApplicationController
  def search
    @range = params[:range]
    if @range == "User"
      @word = params[:word]
      @users = User.looks(params[:search], params[:word])
    else
      @word = params[:word]
      @books = Book.looks(params[:search], params[:word])
    end
  end
end
