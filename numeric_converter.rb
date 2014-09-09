module NumericConverter
  PREVIOUS = -1
  NUMS = {
      0 => 'zero',
      1 => 'one',
      2 => 'two',
      3 => 'three',
      4 => 'four',
      5 => 'five',
      6 => 'six',
      7 => 'seven',
      8 => 'eight',
      9 => 'nine',
      10 => 'ten',
      11 => 'eleven',
      12 => 'twelve',
      13 => 'thirteen',
      14 => 'fourteen',
      15 => 'fifteen',
      16 => 'sixteen',
      17 => 'seventeen',
      18 => 'eighteen',
      19 => 'nineteen',
    }

  TENS = {
      1 => 'ten',
      2 => 'twenty',
      3 => 'thirty',
      4 => 'fourty',
      5 => 'fifty',
      6 => 'sixty',
      7 => 'seventy',
      8 => 'eighty',
      9 => 'ninety',
    }

  MAGNITUDES = {
      0 => '',
      1 => 'thousand',
      2 => 'million',
      3 => 'billion',
      4 => 'trillion',
      5 => 'quadrillion',
      6 => 'quintillion'
    }

  ERRORS = {
    :negative => 'Please enter a positive number',
    :too_large => 'Number too large'
  }


  def self.group(n)
    groups = []

    n.to_s.split('').reverse.each_with_index do |ch, idx|

      # Create new group every 3 digits
      if idx % 3 == 0
        groups.insert 0, ch
      else
        groups[0] = ch + groups[0]
      end
    end
    groups
  end

  def self.convert_pair(pair)
    pair = pair.to_i

    return NUMS[pair] if pair < 20

    "#{TENS[pair.to_s[0].to_i]} #{NUMS[pair.to_s[1].to_i]}"
  end

  def self.convert_triplet(triplet)
    triplet = triplet.to_i

    return convert_pair(triplet) if triplet.to_s.length < 3

    "#{NUMS[triplet.to_s[0].to_i]} hundred #{convert_pair(triplet.to_s[1..2])}"
  end

  def self.convert(n)
    n = n.to_i

    raise ArgumentError, ERRORS[:negative] if n < 0

    raise ArgumentError, ERRORS[:too_large] unless MAGNITUDES.has_key? n.to_s.length / 3

    groups = group n

    out = ''

    groups.reverse.each_with_index do |group, idx|
      out = " #{convert_triplet group} #{MAGNITUDES[idx]}" + out
    end
    out.strip
  end

  private_class_method :group, :convert_pair, :convert_triplet
end
