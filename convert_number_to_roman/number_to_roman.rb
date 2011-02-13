module NumberToRoman
  NUMBER_MAPPING = {
    "M" => 1000,
    "CM" => 900,
    "D" => 500,
    "CD" => 400,
    "C" => 100,
    "XC" => 90,
    "L" => 50,
    "XL" => 40,
    "X" => 10,
    "IX" => 9,
    "V" => 5,
    "IV" => 4,
    "I" => 1,
  }

  def self.convert(number)
    fail ArgumentError.new("Can't convert #{number}") unless (1..3999).include?(number)

    roman = ''
    
    NUMBER_MAPPING.each do |key, value|
      count, number = number.divmod(value)

      roman << (key * count)

      break if number.zero?      
    end

    roman
  end
end

