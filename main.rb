require 'pry'

require_relative 'menu'
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

puts`clear`
puts"Euro Bank plc. \n here to take your money.\n\n"


user_type = main_menu

case user_type
when  1
  client_number = client_login
  choice = client_menu(clients, client_number)
when 2
  manager_login
  choice = manager_menu
end

while choice != 'q'
  case choice
  #client functions
  when 1
    puts "choice 1"

  #manager functions
  when 'a'
    puts "choice a"

    #List Clients

  when 'q'
    puts "Goodbye."
  end

end





binding.pry

