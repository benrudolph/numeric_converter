require_relative '../numeric_converter.rb'

describe NumericConverter, '#convert' do
  it 'returns zero for 0' do
    out = NumericConverter.convert 0
    expect(out).to eq('zero')

    out = NumericConverter.convert '0'
    expect(out).to eq('zero')
  end

  it 'should return correct num for less than twenty' do
    out = NumericConverter.convert '13'
    expect(out).to eq('thirteen')
  end

  it 'should return correct number for 80' do
    out = NumericConverter.convert '80'
    expect(out).to eq('eighty')
  end

  it 'should return correct number for 1880' do
    out = NumericConverter.convert '1880'
    expect(out).to eq('one thousand eight hundred eighty')
  end

  it 'should return correct number for a 234' do
    out = NumericConverter.convert '234'
    expect(out).to eq('two hundred thirty four')
  end

  it 'should return correct number for a 1234' do
    out = NumericConverter.convert '1234'
    expect(out).to eq('one thousand two hundred thirty four')
  end

  it 'should return correct number for a 1234678' do
    out = NumericConverter.convert '1234678'
    expect(out).to eq('one million two hundred thirty four thousand six hundred seventy eight')
  end

  it 'should raise negative' do
    expect{NumericConverter.convert('-10')}.to raise_error(ArgumentError)
  end

  it 'should raise too large error' do
    expect{NumericConverter.convert('123123123123123123123')}.to raise_error(ArgumentError)
  end
end
