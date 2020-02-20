json.extract! person, :id, :name, :phone, :email, :address, :address2, :sale_rep, :delivery_date, :note, :deliver, :fee, :discount, :total, :sub_total, :tax, :cost, :profit, :margin, :city, :state, :zip, :user_id, :created_at, :updated_at
json.url person_url(person, format: :json)
