# Range 246515-739105

lower_bound = 246_515
upper_bound = 739_105

# Conditions
# Two adjacent digits are the same
# from left to right digits never decrease

def never_decrease(number)
  array = number.to_s.chars.map(&:to_i)

  array.each_with_index do |n, i|
    break if i == array.length - 1
    return false if n > array[i + 1]
  end

  true
end

def two_adjacent_are_the_same(number)
  array = number.to_s.chars.map(&:to_i)

  array.each_with_index do |n, i|
    break if i == array.length - 1
    return true if n == array[i + 1]
  end

  false
end

def one_number_repeated_stricly_twice(number)
  array = number.to_s.chars.map(&:to_i)

  array.each_with_index do |n, i|
    break if i == array.length - 1
    return true if n == array[i + 1] && array.count(n) == 2
  end

  false
end

valid_numbers = 0

(lower_bound..upper_bound).each do |n|
  valid_numbers += 1 if never_decrease(n) && one_number_repeated_stricly_twice(n)
end

puts valid_numbers
