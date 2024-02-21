require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  # Setup test data with FactoryBot
  let(:admin) { create(:admin) }
  let(:attendee) { create(:attendee) }
  let(:event) { create(:event) }

  # Define valid attributes for test cases utilizing proper entries.
  let(:valid_attributes) {
    {
      attendee_id: attendee.id,
      event_id: event.id,
      admin_id: admin.id,
      rating: 5,
      feedback: "Had so much fun!"
    }
  }
  # Define invalid attributes for test cases utilizing improper entries.
  let(:invalid_attributes) {
    {
      attendee_id: nil,
      event_id: nil,
      admin_id: nil,
      rating: nil,
      feedback: ""
    }
  }

  before do
    # Authenticate as admin
    sign_in admin
  end

  describe "GET #index" do
    it "assigns all reviews as @reviews" do
      # Arrange: Create a new review record in the database.
      review = Review.create! valid_attributes

      # Act: Make a GET request to the index action of the controller.
      get :index

      # Assert: Verify that all reviews are correctly assigned to @reviews.
      # Check that the @reviews instance variable equals an array with the created review.
      # Ensure the index action correctly assigns all reviews.
      expect(assigns(:reviews)).to eq([review])
    end
  end

  describe "GET #show" do
    it "assigns the requested review as @review" do
      # Arrange: Create a new review record in the database.
      review = Review.create! valid_attributes

      # Act: Make a GET request to the show action with the review's id as a parameter.
      get :show, params: { id: review.to_param }
      # Assert: Verify that the @review instance variable is correctly assigned to the requested review.
      # Check that the show action correctly identifies and assigns the specific review
      # to the @review variable for use in the view.
      expect(assigns(:review)).to eq(review)
    end
  end

  describe "GET #new" do
    it "assigns a new review as @review" do
      # Act: Make a GET request to the new action of the controller.
      get :new
      # Assert: Verify that the @review instance variable is assigned a new unsaved Review instance.
      # Check a new review is initialized.
      expect(assigns(:review)).to be_a_new(Review)
    end
  end

  describe "GET #edit" do
    it "assigns the requested review as @review" do
      # Arrange: Create a new review record in the database using valid attributes.
      review = Review.create! valid_attributes

      # Act: Make a GET request to the edit action with the review's ID as a parameter.
      get :edit, params: { id: review.to_param }

      # Assert: Verify that the @review instance variable is assigned the requested review.
      # Check that the edit action can identify and assign the specific review
      # to the @review variable for use in the view to ensure availability for editing.
      expect(assigns(:review)).to eq(review)
    end
  end


  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new review" do
        # Arrange: (valid_attributes are defined above.)

        # Act & Assert: Post a request to create a new review with valid attributes
        # verifying that this action increases the review count by 1.
        # Check that a new review is successfully created in the database.
        expect {
          post :create, params: { review: valid_attributes }
        }.to change(Review, :count).by(1)
      end

      it "redirects to the created review" do
        # Act: Post a request to create a new review with valid attributes.
        post :create, params: { review: valid_attributes }

        # Assert: Verify the response redirects to the newly created review's show page.
        # Check that users are directed to view the review they just created.
        expect(response).to redirect_to(Review.last)
      end
    end

    context "with invalid attributes" do
      it "returns a response indicating the request was unprocessable" do
        # Arrange: (Invalid_attributes are defined above.)

        # Act: Post a request to create a new review with invalid attributes.
        post :create, params: { review: invalid_attributes }

        # Assert: Check that the response indicates the request was unprocessable.
        # Implies new review form is re-rendered.
        # Ensure new review form correctly handles invalid entries displays validation errors.
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

  end


  describe "PUT #update" do
    context "with valid attributes" do
      let(:new_attributes) {
        # Define attributes for a valid update.
        { feedback: "Updated feedback" }
      }

      it "updates the requested review" do
        # Arrange: Create a review using valid attributes.
        review = Review.create! valid_attributes

        # Act: Update review with new valid attributes.
        put :update, params: { id: review.to_param, review: new_attributes }

        # Assert: Check that the review's attributes are updated as intended.
        review.reload
        # Verify the review is updated.
        expect(review.feedback).to eq("Updated feedback")
      end

      it "redirects to the show review  view" do
        # Arrange: Create a review with valid attributes.
        review = Review.create! valid_attributes

        # Act: Update review with new valid attributes.
        put :update, params: { id: review.to_param, review: new_attributes }

        # Assert: Verify the response redirects to the updated review's show page.
        expect(response).to redirect_to(review)
      end
    end

    context "with invalid params" do
      it "returns a response indicating the request was unprocessable" do
        # Arrange: Create a review with valid attributes.
        review = Review.create! valid_attributes

        # Act: Attempt to update the review with invalid attributes.
        put :update, params: { id: review.to_param, review: invalid_attributes }

        # Assert: Check that the response indicates the request was unprocessable; implies edit form is re-rendered.
        # Ensure the update process correctly handles to invalid entries.
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end


  describe "DELETE #destroy" do
    it "deletes the requested review" do
      # Arrange: Create a review with valid attributes for deletion.
      review = Review.create! valid_attributes

      # Act & Assert: Delete review and verify review count decreases by 1.
      # Test the delete action's ability to remove a review from the database.
      expect {
        delete :destroy, params: { id: review.to_param }
      }.to change(Review, :count).by(-1)
    end

    it "redirects to the view reviews list" do
      # Arrange: Create review with valid attributes for deletion.
      review = Review.create! valid_attributes

      # Act: Delete the review.
      delete :destroy, params: { id: review.to_param }

      # Assert: Verify the response redirects to the list of reviews.
      # Confirm redirection to the reviews list post review deletion.
      expect(response).to redirect_to(reviews_url)
    end
  end
end