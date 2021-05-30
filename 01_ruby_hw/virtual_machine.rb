class VirtualMachine
  attr_reader :info, :volumes

  def initialize(opt = {id: 0, cpu: 0, ram: 0, type: "sata", size: 0, price: 0})
    @info = {
      id: opt[:id].to_i,
      cpu: opt[:cpu].to_i,
      ram: opt[:ram].to_i,
      # Основной диск
      type: opt[:type],
      size: opt[:size].to_i,
      price: 0
    }
    # Дополнительные диски
    @volumes = Array.new

    info[:price] = opt[:prices][info[:type]].to_i * info[:size] +
      opt[:prices]['cpu'].to_i * info[:cpu] +
      opt[:prices]['ram'].to_i * info[:ram]
  end
  # Подсчет дополнительных дисков
  def add_hdd(opt = {type: "sata", size: 0, prices: 0})
    if opt[:prices] != 0
      volumes.push(opt[:type] => opt[:size].to_i)
      info[:price] += opt[:prices][opt[:type]].to_i * opt[:size].to_i
    end
  end
end