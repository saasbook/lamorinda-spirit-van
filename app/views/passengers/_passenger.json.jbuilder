json.extract! passenger, :id, :first_name, :last_name, :full_name, :address, :city, :state, :zip, :phone, :alternative_phone, :birthday, :race, :hispanic, :email, :notes, :date_registered, :audit, :created_at, :updated_at
json.url passenger_url(passenger, format: :json)
