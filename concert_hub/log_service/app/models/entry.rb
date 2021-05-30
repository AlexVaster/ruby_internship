class Entry < ApplicationRecord
  validates :ticket_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :fio, presence: true
  validates :entry_type, inclusion: { in: %w[entry exit] }
  validates :status, inclusion: { in: [true, false] }

  enum entry_type: { entry: 0, exit: 1 }
end
