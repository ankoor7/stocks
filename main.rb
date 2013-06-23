#coding: utf-8
require 'pry'

require_relative 'menu'
require_relative 'stock'
require_relative 'portfolio'
require_relative 'client'

def add_client(client_list, account_number, name, age, sex, cash)
  client_list[account_number]  = Client.new(name, age, sex, cash)
end

def lookup_stock_value(stock_code)
    YahooFinance.get_realtime_quotes(stock_code)[stock_code].ask
end

def lookup_stock(stock_code)
    YahooFinance.get_standard_quotes(stock_code)[stock_code]
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
clients['00069'].portfolios['test'].add_stock('AMZN',2)
clients['00069'].create_portfolio('test2')
clients['00069'].portfolios['test2'].add_stock('AAPL',20)
clients['00069'].portfolios['test2'].add_stock('AMZN',20)

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
  #client functions 1) List your portfolios \n 2) List the stock in a portfolio 3) List the stocks in all your portfolios 4) Display your cash funds 5) Buy some stocks 6) Sell some stocks  7) Lookup a stock price 8) Make a cash deposit q) Exit
  when '1'
    clients[client_number].list_portfolios
  when '2'
    puts "Which portfolio do you want to inspect?"
    portfolio_name = gets.chomp
    clients[client_number].portfolios[portfolio_name].list_stocks
  when '3'
    clients[client_number].portfolios.each { |k, v|
      v.list_stocks
    }
  when '4'
    puts "You have £#{clients[client_number].cash} in your account.\n"

  when '5'
    puts "What stock would you like to buy?"
    stock_code = gets.chomp.upcase
    while lookup_stock_value(stock_code) == nil
      puts "That is not a valid stock code name. Please try again "
      stock_code = gets.chomp.upcase
    end
    puts "How many would you like to buy?"
    number = gets.chomp.to_i
    cost = number * lookup_stock_value(stock_code)
    if cost > clients[client_number].cash
      puts "Sorry, you do not have the funds to make this purchase at this time."
    else
      puts "Which portfolio should store these stocks?"
      portfolio = gets.chomp
      while clients[client_number].portfolios.has_key?(portfolio) == false
        puts "That is not a valid portfolio name. Your portfolios are, "
        clients[client_number].list_portfolios
        puts "Which portfolio should store these stocks?"
        portfolio = gets.chomp
      end
      clients[client_number].portfolios[portfolio].add_stock(stock_code,number)
    end
  when '6'
      puts "Which portfolio do you want to open? "
      portfolio = gets.chomp
      while clients[client_number].portfolios.has_key?(portfolio) == false
        puts "That is not a valid portfolio name. Your portfolios are, "
        clients[client_number].list_portfolios
        puts "Which portfolio should we open?"
        portfolio = gets.chomp
      end
    puts "What stock would you like to sell?"
    stock_code = gets.chomp.upcase
    while clients[client_number].portfolios[portfolio].stocks.has_key?(stock_code) == false
      puts "We could not find that stock. Please try again "
      stock_code = gets.chomp.upcase
    end
    puts "How many would you like to sell?"
    number = gets.chomp.to_i
    if number > clients[client_number].portfolios[portfolio].stocks[stock_code].number_of_stocks
      puts "You only have #{clients[client_number].portfolios[portfolio].stocks[stock_code].number_of_stocks} stocks. We will sell that many."
      number = clients[client_number].portfolios[portfolio].stocks[stock_code].number_of_stocks
    end
    clients[client_number].portfolios[portfolio].sell_stock(stock_code,number)
    value = number * YahooFinance.get_realtime_quotes(stock_code)[stock_code].ask
    clients[client_number].deposit_cash(value)
    puts "Your #{stock_code} stock has sold for £#{value}. The cash has been deposited in your account."
  when '7'
    puts "What stock would you like to see?"
    stock_code = gets.chomp.upcase
    while lookup_stock(stock_code) == nil
      puts "That is not a valid stock code name. Please try again "
      stock_code = gets.chomp.upcase
    end
    data = lookup_stock(stock_code)
    puts "#{stock_code} stock is worth £#{data.ask} per stock\n"
  when '8'
    puts "How much cash would you like to deposit?"
    deposit = gets.chomp.to_f
    clients[client_number].deposit_cash(deposit)
    puts "Thankyou, you now have £#{clients[client_number].cash} in your account.\n"
  #manager functions
  when 'a'
    #List Clients
    puts "Your clients are:"
    clients.each { |k, v|
      puts "#{v.name} has £#{v.cash} cash and £#{v.combined_portfolio_value} in stocks"
    }
    puts "\n"
  end

  case user_type
  when  1
    choice = client_menu(clients, client_number)
  when  2
    choice = manager_menu
  end

end



#binding.pry
