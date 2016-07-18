require 'rake'
Rake::Task.clear

class RakeController < ApplicationController
  skip_before_action :verify_authenticity_token

  def run
    Rails.application.load_tasks
    begin
      Rake::Task["crawler:start"].invoke
      payload = {
        error: 'Error: No error',
        status: 200
      }
    rescue Exception => e
      payload = {
        error: 'Error ' + e.to_s,
        status: 400
      }
    end
    render json: payload, status: payload[:status]
  end

end
