# frozen_string_literal: true

require "rails_helper"

RSpec.describe PassengersController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user, :dispatcher)
    sign_in @user

    @address1 = FactoryBot.create(:address)
    @passenger1 = FactoryBot.create(:passenger)
    @passenger2 = FactoryBot.create(:passenger)
  end

  describe "GET #index" do
    it "returns http success for HTML format" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "returns DataTables JSON with correct structure" do
      get :index, format: :json, params: {
        draw: "1", start: "0", length: "10",
        order: { "0" => { column: "1", dir: "asc" } },
        columns: {}
      }
      json = JSON.parse(response.body)
      expect(json).to include("draw", "recordsTotal", "recordsFiltered", "data")
      expect(json["recordsTotal"]).to eq(Passenger.count)
      expect(json["data"]).to be_an(Array)
    end

    it "paginates: returns only the requested page size" do
      get :index, format: :json, params: {
        draw: "1", start: "0", length: "1",
        order: { "0" => { column: "1", dir: "asc" } },
        columns: {}
      }
      json = JSON.parse(response.body)
      expect(json["data"].length).to eq(1)
      expect(json["recordsTotal"]).to eq(Passenger.count)
    end

    it "filters by passenger name" do
      search_term = @passenger1.name.downcase[0, 4]
      get :index, format: :json, params: {
        draw: "1", start: "0", length: "10",
        order: { "0" => { column: "1", dir: "asc" } },
        columns: { "1" => { search: { value: search_term } } }
      }
      json = JSON.parse(response.body)
      expect(json["recordsFiltered"]).to be <= json["recordsTotal"]
    end

    it "filters by birthday range" do
      get :index, format: :json, params: {
        draw: "1", start: "0", length: "10",
        order: { "0" => { column: "1", dir: "asc" } },
        columns: { "9" => { search: { value: "1900-01-01|2000-01-01" } } }
      }
      json = JSON.parse(response.body)
      expect(json["data"]).not_to be_empty
    end

    it "falls back to default sort when column index is unmapped" do
      get :index, format: :json, params: {
        draw: "1", start: "0", length: "10",
        order: { "0" => { column: "99", dir: "asc" } },
        columns: {}
      }
      expect(response).to have_http_status(:success)
    end

    it "sorts descending" do
      get :index, format: :json, params: {
        draw: "1", start: "0", length: "10",
        order: { "0" => { column: "1", dir: "desc" } },
        columns: {}
      }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: @passenger1.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "builds a new passenger with an associated address" do
      get :new
      expect(assigns(:passenger)).to be_a_new(Passenger)
      expect(assigns(:passenger).address).to be_a_new(Address)
    end
  end

  describe "POST #create" do
    let(:valid_attributes) do
      {
        name: "New Passenger",
        phone: "555-555-5555",
        email: "newpassenger@example.com",
        race: 1,
        hispanic: "Yes",
        birthday: "1950-01-01",
        date_registered: "2024-01-01",
        address_attributes: {
          street: "999 Unique Blvd",
          city: "Orinda",
          zip_code: "94563"
        }
      }
    end

    it "creates a new passenger and redirects" do
      expect {
        post :create, params: { passenger: valid_attributes }
      }.to change(Passenger, :count).by(1)
      expect(response).to redirect_to(passengers_path)
      expect(flash[:notice]).to eq("Passenger created.")
    end

    it "creates a new address when a unique one is provided" do
      expect {
        post :create, params: { passenger: valid_attributes }
      }.to change(Address, :count).by(1)
    end

    it "reuses an existing address on create" do
      existing = FactoryBot.create(:address, street: "100 Shared Ln", city: "Lafayette", zip_code: "94549")
      attrs = valid_attributes.merge(address_attributes: {
        street: "100 Shared Ln", city: "Lafayette", zip_code: "94549"
      })
      expect {
        post :create, params: { passenger: attrs }
      }.not_to change(Address, :count)
      expect(Passenger.last.address_id).to eq(existing.id)
    end

    it "renders new when passenger creation fails" do
      post :create, params: { passenger: { address_id: nil } }
      expect(response).to render_template(:new)
    end
  end

  describe "PUT #update" do
    it "updates the passenger and redirects" do
      put :update, params: { id: @passenger1.id, passenger: { name: "Updated Name" } }
      expect(response).to redirect_to(edit_passenger_path(@passenger1))
      expect(flash[:notice]).to eq("Passenger updated.")
    end

    it "updates boolean fields correctly" do
      put :update, params: { id: @passenger1.id, passenger: { wheelchair: true, low_income: false } }
      @passenger1.reload
      expect(@passenger1.wheelchair).to eq(true)
      expect(@passenger1.low_income).to eq(false)
    end

    it "hits the error branch when the address is invalid" do
      invalid_params = {
        id: @passenger1.id,
        passenger: {
          name: "Valid Name",
          address_attributes: {
            id: @passenger1.address.id,
            street: "Valid Street 999" # no city — fails Address validation
          }
        }
      }
      put :update, params: invalid_params
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:edit)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the passenger and redirects to passengers_path" do
      expect {
        delete :destroy, params: { id: @passenger1.id }
      }.to change(Passenger, :count).by(-1)
      expect(response).to redirect_to(passengers_path)
      expect(flash[:notice]).to eq("Passenger deleted.")
    end

    it "does not destroy the associated address record" do
      address_id = @passenger1.address_id
      delete :destroy, params: { id: @passenger1.id }
      expect(Address.exists?(address_id)).to be true
    end
  end

  describe "authorization" do
    it "redirects unauthenticated users away from index" do
      sign_out @user
      get :index
      expect(response).not_to have_http_status(:success)
    end
  end
end
