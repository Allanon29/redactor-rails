module RedactorRails
  module Devise
    def redactor_authenticate_member!
      authenticate_member!
    end

    def redactor_current_member
      current_member
    end
  end
end
