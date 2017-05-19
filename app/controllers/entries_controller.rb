class EntriesController < ApplicationController

  def index
    @entries = Entry.paginate(page: params[:page])
  end

  def show
    @entry = Entry.find(params[:id])
  end
end
