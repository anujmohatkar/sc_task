module Api
  class MathsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: %i[max_sum]

    def max_sum
      nums = params[:numbers].map(&:to_i)
      if nums.length == 1 # return nums as only 3 numbers are passed
        max_sum_nums = nums
      elsif nums.empty?
        max_sum_nums = "Not Enough Numbers" # not enough numbers are passed
      else
        i = 0 # save maximum sum's`` start index here.
        j = 0 # save maximum sum's end index here.
        s = nums[i] # save the max sum here, defaults to the first number in the array.
        nums.each_with_index do |n, ni| 
          k = ni
          (nums.length-k).times do
            if nums[ni..k].sum > s
              i = ni
              j = k
              s = nums[ni..k].sum
            end
            k += 1
          end
        end
        max_sum_nums = nums[i..j]
      end

      render json: {max_sum: max_sum_nums}
    end
  end
end