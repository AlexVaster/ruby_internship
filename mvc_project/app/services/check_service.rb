# frozen_string_literal: true

require 'httpclient'
# Класс, используемый для подсчета затрат на покупку ВМ
class CheckService
  attr_reader :vm_data

  def initialize(params, balance)
    @vm_data = {
      cpu: params[:cpu].to_i,
      ram: params[:ram].to_i,
      hdd_type: params[:hdd_type],
      hdd_capacity: params[:hdd_capacity].to_i,
      os: params[:os],
      balance: balance
    }
  end

  def call
    process_order
  end

  private

  def process_order
    return result = [{result: false, error: 'Not Acceptable, because bad configuration'}, status: 406] unless check_combo
    return result = [{result: false, error: 'Not Acceptable, because not enough money'}, status: 406] unless check_balance
    result = [{result: true, 
      total: calculate_price, 
      balance: vm_data[:balance], 
      balance_after_transaction: after_balance},
      status: 200]
  end
  
  def get_possible_orders
    clnt = HTTPClient.new
    response = clnt.request(:get, 'http://possible_orders.srv.w55.ru/')
    response.status == 200 ? JSON.parse(response.body) : 503
  end

  def check_combo
    combos = get_possible_orders
    return result = [{result: false, error: 'Service Unavailable'}, status: 503] if combos == 503
    combos['specs'].each do |v|
      if vm_data[:os] == v['os'].first.to_s && 
        v['cpu'].include?(vm_data[:cpu]) && 
        vm_data[:ram] == v['ram'].first.to_i && 
        v['hdd_type'].include?(vm_data[:hdd_type]) && 
        (v['hdd_capacity'][vm_data[:hdd_type]]['from'].to_i..
        v['hdd_capacity'][vm_data[:hdd_type]]['to'].to_i).include?(vm_data[:hdd_capacity])
        return true
      end
    end
    return false
  end

  def calculate_price
    http_calc = HTTPClient.new
    http_calc.request(
      :get, "http://server:5678/?"+
      "cpu=#{vm_data[:cpu]}&"+
      "ram=#{vm_data[:ram]}&"+
      "hdd_type=#{vm_data[:hdd_type]}&"+
      "hdd_capacity=#{vm_data[:hdd_capacity]}").body.to_i
  end

  def check_balance
    vm_data[:balance] - calculate_price > 0
  end

  def after_balance
    vm_data[:balance] - calculate_price
  end
end