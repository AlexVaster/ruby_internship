module Error
  class EntryInvalid < CustomError
    attr_reader :details

    def initialize(errors_messages)
      @details = errors_messages
      super('Entry is invalid')
    end
  end
end
