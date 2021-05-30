module Error::Helpers
  class Render
    def self.json(message, details = nil)
      (details ? { error: message, details: details } : { error: message }).as_json
    end
  end
end
