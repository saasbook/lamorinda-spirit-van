require "rails_helper"

RSpec.describe ShiftsController, type: :controller do
  let(:driver) { Driver.create(name: "Test Driver") }
  let(:shift) { Shift.create(shift_date: Date.today, shift_type: "morning", driver: driver) }

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      get :show, params: { id: shift.id }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a successful response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new shift and redirects to the shift page" do
        expect {
          post :create, params: { shift: { shift_date: Date.today, shift_type: "evening", driver_id: driver.id } }
        }.to change(Shift, :count).by(1)

        expect(response).to redirect_to(Shift.last)
      end
    end

    context "with invalid parameters" do
      it "does not create a shift and re-renders the new template" do
        expect {
          post :create, params: { shift: { shift_date: nil, shift_type: "morning", driver_id: driver.id } }
        }.not_to change(Shift, :count)

        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    it "returns a successful response" do
      get :edit, params: { id: shift.id }
      expect(response).to be_successful
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      it "updates the shift and redirects to the shift page" do
        patch :update, params: { id: shift.id, shift: { shift_type: "night" } }
        shift.reload
        expect(shift.shift_type).to eq("night")
        expect(response).to redirect_to(shift)
      end
    end

    context "with invalid parameters" do
      it "does not update the shift and re-renders the edit template" do
        patch :update, params: { id: shift.id, shift: { shift_date: nil } }
        shift.reload
        expect(shift.shift_date).not_to be_nil
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the shift and redirects to the shifts index" do
      shift
      expect {
        delete :destroy, params: { id: shift.id }
      }.to change(Shift, :count).by(-1)

      expect(response).to redirect_to(shifts_path)
    end
  end
end
