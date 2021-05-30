require 'csv'

class DataBase
  attr_accessor :prices, :arr_of_vms

  def initialize(opt = {prices: 'prices.csv', vms: 'vms.csv', volumes: 'volumes.csv'})
    @prices = Hash.new
    @arr_of_vms = Array.new
    CSV.foreach(opt[:prices]) do |row|
      prices[row[0]] = row[1]
    end
    # Для каждой ВМ создаем экземпляр VirtualMachine
    CSV.foreach(opt[:vms]) do |row|
      arr_of_vms << VirtualMachine.new(id: row[0], cpu: row[1], ram: row[2], type: row[3], size: row[4], prices: @prices) 
    end
    # Считывем дополнительные диски
    CSV.foreach(opt[:volumes]) do |row|
      arr_of_vms[row[0].to_i].add_hdd(type: row[1], size: row[2], prices: @prices)
    end
  end

  def validate(type)
    raise ArgumentError.new('Wrong type of virtual machine') unless %w(cpu ram sas sata ssd).include?(type)
  end
  # Вывод с самой дорогой ВМ
  def desc_out(n)
    temp = arr_of_vms.sort_by{|row| - row.info[:price]}
    output(n, temp)
  end
  # Вывод с самой дешевой ВМ
  def asc_out(n)
    temp = arr_of_vms.sort_by{|row| row.info[:price]}
    output(n, temp)
  end
  # Вывод по самому большому типу
  def desc_size_out(n, type)
    type = validate(type)
    temp = arr_of_vms.sort_by do |el|
      if type == :ram
        - el.info[:ram]
      elsif type == :cpu
        - el.info[:cpu]
      else
        - (el.volumes.select{|v| v.keys.first == type.to_s}
          .inject(el.info[:type] == type.to_s ? el.info[:size] : 0){|sum, v| sum + v.values.first})
      end
    end
    output(n, temp)
  end
  # Вывод по количеству дополнительных дисков
  def desc_count_hdd(n, hdd_type = :all)
    temp = arr_of_vms.sort_by do |el|
      if hdd_type == :all
        - el.volumes.size
      else
        - el.volumes.select{|v| v.keys.first == hdd_type.to_s}.count
      end
    end
    output(n, temp)
  end
  # Вывод по объему дополнительных дисков
  def desc_size_hdd(n, hdd_type = :all)
    temp = arr_of_vms.sort_by do |el|
      if hdd_type == :all
        - el.volumes.map{|v| v.values.first }.sum
      else
        - el.volumes.select{|v| v.keys.first == hdd_type.to_s }
        .inject(0){|sum, v| sum + v.values.first}
      end
    end
    output(n, temp)
  end
  # Вывод в stdout
  def output(n, arr)
    puts('| ID | CPU| RAM|INTERNAL HDD|    prices   |  SAS  SATA  SSD |  ALL  |COUNT|')
    arr.first(n).each do |row|
      printf("| %-3d| %-3d| %-3d|%-4s: %-6d| %11d|%5s %5s %5s| %6s|%5d|\n",
        row.info[:id], row.info[:cpu], row.info[:ram],
        row.info[:type], row.info[:size], row.info[:price],
        row.volumes.select{|v| v.keys.first == 'sas'}.inject(0){|sum, v| sum + v.values.first},
        row.volumes.select{|v| v.keys.first == 'sata'}.inject(0){|sum, v| sum + v.values.first},
        row.volumes.select{|v| v.keys.first == 'ssd'}.inject(0){|sum, v| sum + v.values.first},
        row.volumes.inject(0){|sum, v| sum + v.values.first},
        row.volumes.count)
    end
    puts 
  end
end