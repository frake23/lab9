# frozen_string_literal: true

require 'sequence'

# home controller
class HomeController < ApplicationController

  def calc
    arr_str = params[:arr]
    if /^(-?\d+ ?)+$/.match? arr_str
      @arr = arr_str.split(' ').map(&:to_i)
      @distances = Sequence.find_distances @arr
      @max_distance = @distances.max { |a, b| a.length <=> b.length }
    else
      flash.alert = 'В строке могут быть только числа или пробелы / может быть не более одного пробела между числами'
    end
  end
end
