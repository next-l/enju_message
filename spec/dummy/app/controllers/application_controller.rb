class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery

  include EnjuLeaf::Controller
  include EnjuLibrary::Controller
end
