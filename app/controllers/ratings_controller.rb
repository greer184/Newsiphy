class RatingsController < ApplicationController
  
  def new
    @rating = Rating.new
    session[:teleport] = params[:entry]
  end

  def create
    if !Entry.find(session[:teleport]).nil?
      @rating = Rating.new(rating_params)
      @rating.user_id = current_user.id
      @rating.entry_id = session[:teleport]
      if @rating.save
        Entry.find(@rating.entry_id).update_score
        flash[:success] = "Rating saved"
      end
    else
      flash[:warning] = "Invalid news story"
    end
    redirect_to root_url
  end
  
  def edit
    @rating = Rating.find(params[:id])
  end

  def update
    @rating = Rating.find(params[:id])
    if @rating.update_attributes(rating_params)
      Entry.find(@rating.entry_id).update_score
      flash[:success] = "Rating updated"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  private
  def rating_params
    params.require(:rating).permit(:score)
  end
end
