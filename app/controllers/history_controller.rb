class HistoryController < ApplicationController
  before_action :load_history, only: :index
  
  def index; end
end
