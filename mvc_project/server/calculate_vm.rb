require 'csv'
require 'cgi'

class Calculator
  def initialize(query)
    @query = query.split(' ')[1].sub('/?','')
    @price = Hash.new
  end

  def read_price(path = 'prices.csv')
    CSV.foreach(path) do |row|
      @price[row[0]] = row[1]
    end
  end

  def result
    input_query = CGI.parse(@query)
    result = 0
    input_query.each do |key, value|
      if key == 'cpu' || key == 'ram'
        result += value[0].to_i * @price[key].to_i
      elsif key == 'hdd_type'
        @hdd_type = value[0]
      elsif key == 'hdd_capacity'
        result += @price[@hdd_type].to_i * value[0].to_i
      elsif key.include? '['
        result += @price[key.split('[').last.split(']').first].to_i * value[0].to_i
      end
    end
    return result
  end
end