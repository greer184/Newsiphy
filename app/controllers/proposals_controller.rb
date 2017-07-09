class ProposalsController < ApplicationController
  before_action :set_proposal, only: [:show, :edit, :update, :destroy]

  def index
    @proposals = Proposal.all
  end

  def show
  end

  def new
    @proposal = Proposal.new
  end

  def edit
  end

  def create
    @proposal = Proposal.new(proposal_params)
    if @proposal.save
      flash[:success] = "Proposal was successfully created"
    else
      flash[:warning] = "Proposal creation failed"
    end
  end

  def update
    if @proposal.update(feed_params)
      flash[:success] = "Changes successfully made"
    else
      flash[:danger] = "Changes unable to be made"
    end
  end

  def destroy
    @proposal.destroy
    flash[:success] = "Proposal was axed"
  end

  private

  def set_proposal
    @proposal = Proposal.find(params[:id])
  end

  def proposal_params
    params.require(:proposal).permit(:description)
  end
end
