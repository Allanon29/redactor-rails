module RedactorRails
  module Helpers
    # Setting Redactor Language
    def redactor_lang(lang = 'hu')
      javascript_include_tag "redactor-rails/langs/hu.js"
    end
  end
end
