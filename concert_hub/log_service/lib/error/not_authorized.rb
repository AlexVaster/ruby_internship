module Error
  class NotAuthorized < CustomError
    def initialize(message = 'You don\'t have enough rights ' \
      'to perform this operation')
      super(message)
    end
  end
end
