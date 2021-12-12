module Sequence
  def find_distances(arr)
    arr
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

  private :po5?
  module_function :find_distances, :po5?
end