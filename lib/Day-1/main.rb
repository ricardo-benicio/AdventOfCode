puts 'Day-1'

# Part 1
input = <<~INPUT
  1abc2
  pqr3stu8vwx
  a1b2c3d4e5f
  treb7uchet
INPUT

r = File.readlines('lib/Day-1/input.txt').map do |line|
  digits = line.scan(/\d/)
  (digits.first + digits.last).to_i
end.sum
p r

# Part 2
input = <<~INPUT
  two1nine
  eightwothree
  abcone2threexyz
  xtwone3four
  4nineeightseven2
  zoneight234
  7pqrstsixteen
INPUT

WORD_TO_DIGIT = {
  'one' => '1',
  'two' => '2',
  'three' => '3',
  'four' => '4',
  'five' => '5',
  'six' => '6',
  'seven' => '7',
  'eight' => '8',
  'nine' => '9',
  '1' => '1',
  '2' => '2',
  '3' => '3',
  '4' => '4',
  '5' => '5',
  '6' => '6',
  '7' => '7',
  '8' => '8',
  '9' => '9',
  '0' => '0',
}

words = WORD_TO_DIGIT.keys
r_words = words.map(&:reverse)

r = File.readlines('lib/Day-1/input.txt').map do |line|
  digits = line.match(/(#{words.join('|')})/, 0)
  first = WORD_TO_DIGIT[digits[0]]

  digits = line.reverse.match(/(#{r_words.join('|')})/, 0)
  last = WORD_TO_DIGIT[digits[0].reverse]

  (first + last).to_i
end.sum
p r
