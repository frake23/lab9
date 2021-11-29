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
      .map { |i| po5?(i) ? i : 0 }
      .reduce([0, []]) { |obj, i| i.zero? ? [obj[0] + 1, obj[1]] : [obj[0], obj[1].push([obj[0], i])] }[1]
      .group_by { |i| i[0] }
      .values
      .map { |i| i.map { |j| j[1] } }
  end

  def po5?(num)
    return false if num <= 0

    while num != 1
      return false unless (num % 5).zero?

      num /= 5
    end
    true
  end

  helper_method :find_distances, :po5?
end
