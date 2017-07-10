class ProposalsController < ApplicationController
  before_action :set_proposal, only: [:show, :edit, :update, :destroy]

  def index
    proposals = Proposal.all
    list = labels
    total = User.all.count * 5.0
    @options = []
    list.each do |op|
      support = 0.0
      proposals.each do |pro|
        if op == pro.description
          support = support + User.find(pro.user_id).voting_power
        end
      end
      percent = ((support / total) * 100).round(2)
      @options.append([op, percent])
    end
  end

  def show
  end

  def new
    @proposal = Proposal.new
    @menu = labels
  end

  def edit
    @menu = labels
  end

  def create
    @proposal = Proposal.new(proposal_params)
    @proposal.user_id = current_user.id
    if @proposal.save
      flash[:success] = "Vote was successfully cast, "
      flash[:success] += "feel free to change before deadline"
    else
      flash[:warning] = "Vote was not correctly logged"
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

  def labels
    list = ["aardvark", "barnacle", "caterpillar", "dragonfly", "earwig"]
  end

  def proposal_params
    params.require(:proposal).permit(:description)
  end

end
