#coding: utf-8
class Portfolio

  attr_accessor :stocks, :name, :total_value, :current_portfolio_value

  def initialize(name)
    @name = name
    @stocks = {}
    @total_value = 0
  end

  def add_stock(stock_code,number)
    if @stocks.has_key?(stock_code)
      @stocks[stock_code].append_stocks(number)
    else
      @stocks[stock_code] = Stock.new(stock_code,number)
      @total_value = calc_total_value
    end
  end

  def calc_total_value
    @current_portfolio_value = 0
    @stocks.each { |k,v| @current_portfolio_value += stocks[k].calc_current_total_stock_value }
    return @current_portfolio_value
  end

  def list_stocks
    puts "This portfolio contains,"
    @stocks.each  { |k,v|
      puts "#{v.number_of_stocks} stocks of #{k} - #{v.company}. Current value is £#{v.calc_current_total_stock_value}."
    }
  end

end