# frozen_string_literal: true

# home controller
class HomeController < ApplicationController
  def calc
    arr_str = params[:arr]
    if /^(-?\d+ ?)+$/.match? arr_str
      @arr = arr_str.split(' ').map(&:to_i)
      @distances = find_distances
      @max_distance = @distances.max { |a, b| a.length <=> b.length }
    else
      @error = 'В строке могут быть только числа или пробелы / может быть не более одного пробела между числами'
    end
  end

  def find_distances
    @arr
      .map {|i| po5?(i) ? i : 0}
      .slice_when {|i, j| po5?(i) != po5?(j)}
      .to_a
      .reject {|i| i.include? 0}
  end

  def po5?(num)
    return false if num <= 0

    while num != 1
      return false unless (num % 5).zero?

      num /= 5
    end
    true
  end
end
