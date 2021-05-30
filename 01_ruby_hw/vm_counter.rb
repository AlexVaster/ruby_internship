require_relative 'virtual_machine'
require_relative 'data_base'

test = DataBase.new

# параметр количества строк
n = ARGV[0].to_i
# параметр типа данных
type = ARGV[1]
# 1 - Отчет который выводит n самых дорогих ВМ
test.desc_out(n)
# 2 - Отчет который выводит n самых дешевых ВМ
test.asc_out(n)
# 3 - Отчет который выводит n самых объемных ВМ по параметру type
test.desc_size_out(n, type)
# 4 - Отчет который выводит n ВМ у которых подключено больше всего дополнительных дисков (по количеству)
test.desc_count_hdd(n, type)
# 5 - Отчет который выводит n ВМ у которых подключено больше всего дополнительных дисков (по объему) 
test.desc_size_hdd(n, type)