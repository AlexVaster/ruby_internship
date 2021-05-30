module Error
  class NotAuthenticate < CustomError
    def initialize(message = 'The username or password is incorrect')
      super(message)
    end
  end
end
