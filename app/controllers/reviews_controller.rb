class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]

  # GET /reviews or /reviews.json
  def index
    # Start with all reviews
    @reviews = Review.all

    # If an attendee ID is passed in the params, filter reviews by that attendee
    if params[:attendee_id].present?
      @reviews = @reviews.where(attendee_id: params[:attendee_id])
    end

    # If an event ID is passed in the params, filter reviews by that event
    if params[:event_id].present?
      @reviews = @reviews.where(event_id: params[:event_id])
    end
  end

  # GET /reviews/1 or /reviews/1.json
  def show
    @review = Review.find(params[:id])
    # This makes the attendee  accessible via @review.attendee.name
    # so we see that instead of the id.
  end

  # GET /reviews/new
  def new
    @review = Review.new
    # If the current user is an attendee, set the attendee_id to their id
    @review.attendee_id = current_attendee.id if attendee_signed_in?
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)
    # For attendees, force the attendee_id to be the current attendee's id
    @review.attendee_id = current_attendee.id if attendee_signed_in?
    respond_to do |format|
      if @review.save
        format.html { redirect_to review_url(@review), notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to review_url(@review), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy

    respond_to do |format|
      format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
  def review_params
    if admin_signed_in?
      params.require(:review).permit(:attendee_id, :event_id, :rating, :feedback)
    elsif attendee_signed_in?
      params.require(:review).permit(:event_id, :rating, :feedback)
    end
  end

end
