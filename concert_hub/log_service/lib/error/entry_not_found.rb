module Error
  class EntryNotFound < CustomError
    def initialize(ticket_id)
      super("Entries for ticket #{ticket_id} not found")
    end
  end
end
