json.extract! ticket, :id, :ticket_id, :ticket_category, :data, :status, :fio, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
