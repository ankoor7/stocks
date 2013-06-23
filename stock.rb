require 'YahooFinance'

class Stock

  attr_accessor :stock_code, :company, :current_investment, :number_of_stocks

  def initialize(stock_code, number_of_stocks)
    @stock_code, @number_of_stocks = stock_code, number_of_stocks
    @company = YahooFinance.get_realtime_quotes(stock_code)[stock_code].name
  end

  def calc_current_stock_value
     YahooFinance.get_realtime_quotes(@stock_code)[@stock_code].ask
  end

  def calc_current_total_stock_value
      calc_current_stock_value * @number_of_stocks
  end

  def append_stocks(number)
    @number_of_stocks = number
  end

end
