module StructoExceptions
  class InternalServerError < StandardError
    def message
      "Woops you got a 500 error! A typical reason for an 500 error (Internal Server Error) is a bad formed URL request. Please check your URL and and the paramerters."
    end
    
  end
end
