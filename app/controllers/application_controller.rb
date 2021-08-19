class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  
  def respond_with_successful data= nil
    render status: 200, json: {
      successful: true,
      data: data
    }.to_json
  end
  
  # JSON failure response
  def respond_with_error message = "", details = []
    render status: 422, json: {
      successful: false,
      error: {
          message: message,
          details: details
      }
    }.to_json
  end
  
  def respond_with_not_found
    render status: 404, json: {
      successful: false,
      error: {
          message: "not_found",
      }
    }.to_json
  end
end
