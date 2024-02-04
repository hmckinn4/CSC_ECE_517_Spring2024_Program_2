json.extract! attendee, :id, :email, :password, :name, :phone_number, :address, :credit_card_info, :created_at, :updated_at
json.url attendee_url(attendee, format: :json)
