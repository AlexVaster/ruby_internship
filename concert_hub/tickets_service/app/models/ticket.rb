class Ticket < ApplicationRecord
  enum status: { free: 0, booked: 1, purchased: 2, blocked: 3 }
end
