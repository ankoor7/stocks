def main_menu
  puts "Are you,.\n 1) a client \n 2) the bank manager \n q) Exit\n\n"
  gets.chomp
  # manager menu
end

def client_login
  # client menu
  puts "Please enter your account number to login: (Hint for WDI team -- type 00069"
  client_number  = gets.chomp.to_s
  authenticate
  return client_number
end

def manager_login
  authenticate
end

def authenticate
  puts "Enter your password"
  gets
end

def client_menu(client_list, client_number)
  puts "Hello, #{client_list[client_number].name}. How may we help you? \n 1) List your portfolios \n 2) List the stock in a portfolio \n 3) List the stocks in all your portfolios \n 4) Display your cash funds \n 5) Buy some stocks \n 6) Sell some stocks  \n 7) Lookup a stock price  \n 8) Make a cash deposit\n\n q) Exit\n\n"
  gets.chomp


end

def manager_menu
  puts "What do you want to do?\n a) List all your clients \n b) add a client\n\n q) Exit\n\n"
  gets.chomp.downcase

end