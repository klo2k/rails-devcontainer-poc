class DebugtestController < ApplicationController
  def index
    @time = Time.new()
    @timeArray = @time.to_a
    print(@timeArray.to_s + "\n")
  end
end
