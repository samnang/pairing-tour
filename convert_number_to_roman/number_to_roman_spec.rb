require 'rspec'
require_relative 'number_to_roman'

describe NumberToRoman do

  def verify_convert_number(number, expected)
    NumberToRoman.convert(number).should == expected
  end

  it "convert 1 to I" do
    verify_convert_number(1, "I")
  end

  it "convert 3 to III" do
    verify_convert_number(3, "III")
  end

  it "convert 5 to V" do
    verify_convert_number(5, "V")
  end

  it "convert 4 to IV" do
    verify_convert_number(4, "IV")
  end

  it "convert 7 to VII" do
    verify_convert_number(7, "VII")
  end

  it "convert 9 to IX" do
    verify_convert_number(9, "IX")
  end

  it "convert 10 to X" do
    verify_convert_number(10, "X")
  end

  it "convert 15 to XV" do
    verify_convert_number(15, "XV")
  end

  it "convert 16 to XVI" do
    verify_convert_number(16, "XVI")
  end

  it "convert 50 to L" do
    verify_convert_number(50, "L")
  end

  it "convert 40 to XL" do
    verify_convert_number(40, "XL")
  end

  it "convert 46 to XLVI" do
    verify_convert_number(46, "XLVI")
  end

  it "convert 88 to LXXXVIII" do
    verify_convert_number(88, "LXXXVIII")
  end

  it "convert 99 to XCIX" do
    verify_convert_number(99, "XCIX")
  end

  it "convert 123 to CXXIII" do
    verify_convert_number(123, "CXXIII")
  end

  it "convert 479 to CDLXXIX" do
    verify_convert_number(479, "CDLXXIX")
  end

  it "convert 666 to DCLXVI" do
    verify_convert_number(666, "DCLXVI")
  end

  it "convert 999 to CMXCIX" do
    verify_convert_number(999, "CMXCIX")
  end

  it "convert 1259 to MCCLIX" do
    verify_convert_number(1259, "MCCLIX")
  end

  it "convert 3999 to MMMCMXCIX" do
    verify_convert_number(3999, "MMMCMXCIX")
  end

  it "raise exception for 0" do
    lambda { verify_convert_number(0, "Nothing") }.should raise_error ArgumentError 
  end

  it "raise exception for > 4000" do
    lambda { verify_convert_number(4000, "Nothing") }.should raise_error ArgumentError 
  end
end
