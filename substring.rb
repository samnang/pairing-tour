#For example, if the two strings were:
#String 1: ABCDEFGHLMNOPQRS
#String 2: DCGSRQPOM
#You'd get true as every character in string2 is in string1. 

#If the two strings were:
#String 1: ABCDEFGHLMNOPQRS
#String 2: DCGSRQPOZ
#you'd get false as Z isn't in the first string. 

require 'benchmark'

one = "ABCDEFGHLMNCOPQRSD"
two = "DCGSRQPOMDC"

class String
  def has_substring?(str)
    sub_chars = str.split('').sort

    sub_chars.each do |c|
      return false unless self.sub!(c, '')
    end

    true
  end
end

class Array
  def check_subarray(other_arr)
    arr = self.map do |item|
      return false if other_arr.find_index(item).nil?

      other_arr.delete_at(other_arr.find_index(item))
    end
    
    true
  end
end

puts two.split('').check_subarray(one.split(''))

Benchmark.bm do |x|
  x.report { 5000.times do; one.has_substring?(two); end }
  x.report { 5000.times do; two.split('').check_subarray(one.split('')); end}
end
