class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  def set_default_response_format
    request.format = :json
  end 
end
