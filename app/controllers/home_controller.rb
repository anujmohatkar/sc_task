class HomeController < ApplicationController
  before_action :authenticate_user!, only: %i[index]

  def index
    redirect_to tasks_path if current_user
  end

  def not_found
  end

  def max_sum
    nums = params[:numbers]
    if nums.length == 3 # return nums as only 3 numbers are passed
      sum_nums = nums
    elsif nums.length < 3
      sum_nums = "Not Enough Numbers" # not enough numbers are passed
    else
      i = 0 # save maximum sum index here.
      nums[0..-3].each_with_index do |n, ni| 
        if (nums[i] + nums[i+1] + nums[i+2]) < (n + nums[ni+1] + nums[ni+2])
          i = ni
        end
      end
      sum_nums = [nums[i], nums[i+1], nums[i+2] ]
    end
    respond_to do |format|
      format.json { render json: {max_sum: sum_nums}}
    end
  end
end
