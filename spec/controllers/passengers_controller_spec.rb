# frozen_string_literal: true

require "rails_helper"

RSpec.describe PassengersController, type: :controller do
  before(:each) do
     @address1 = FactoryBot.create(:address)
     @passenger1 = FactoryBot.create(:passenger)
     @passenger2 = FactoryBot.create(:passenger)
   end

  describe "POST #create" do
    context "with valid attributes" do
      let(:valid_attributes) do
        {
          street: "1",
          city: "1",
          state: "1",
          zip: "1",
          race: 1,
          name: "1",
          birthday: Time.zone.today,
          hispanic: true,
          date_registered: Time.zone.today
        }
      end

      # Tests successful creation of a passenger
      # it "creates a new passenger and redirects" do
      #   puts(valid_attributes)
      #   post :create, params: { passenger: valid_attributes }
      #   expect(response).to redirect_to(passengers_path)
      #   expect(flash[:notice]).to eq("Passenger was successfully created.")
      # end

      # Tests failed creation due to missing required parameters
      it "renders new when passenger creation fails" do
        post :create, params: { passenger: { address_id: nil } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT #update" do
    # Tests successful update of a passenger
    it "updates the passenger and redirects" do
      put :update, params: { id: @passenger1.id, passenger: { name: "Updated Name" } }
      expect(response).to redirect_to(edit_passenger_path(@passenger1))
      expect(flash[:notice]).to eq("Passenger updated.")
    end
  end
end
