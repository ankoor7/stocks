require 'pry'


require_relative 'stock'
require_relative 'portfolio'
require_relative 'client'

def add_client(client_list, account_number, name, age, sex, cash)
  client_list[account_number]  = Client.new(name, age, sex, cash)
end

f = File.new('names.txt', 'r')
people = Array.new
f.each { |line|
  person_array = line.chomp.split(", ")
  people << person_array
}
f.close

# Add initial client list
clients = {}
people.each_with_index {|el, i|
  account_number = "%05d" % i
  clients[account_number]  = Client.new(el[0], el[1], el[2], 0)
}

#test data
clients['00069'].create_portfolio('test')
clients['00069'].portfolios['test'].add_stock('AAPL',2)
clients['00069'].portfolios['test'].list_stocks


binding.pry
