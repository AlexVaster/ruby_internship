require 'csv'
require 'cgi'

class Calculator
  attr_reader :prices
  def initialize(query, prices)
    @query = query.split(' ')[1].sub('/?','')
    @prices = prices
  end

  def result
    input_query = CGI.parse(@query)
    result = 0
    input_query.each do |key, value|
      if key == 'cpu' || key == 'ram'
        result += value[0].to_i * prices[key].to_i
      elsif key == 'hdd_type'
        @hdd_type = value[0]
      elsif key == 'hdd_capacity'
        result += prices[@hdd_type].to_i * value[0].to_i
      elsif key.include? '['
        result += prices[key.split('[').last.split(']').first].to_i * value[0].to_i
      end
    end
    return result
  end
end