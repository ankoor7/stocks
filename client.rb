#coding: utf-8
class Client
  attr_accessor :name, :sex, :age, :cash, :portfolios

  def initialize(name, sex, age, cash)
    @name, @age, @sex, @cash = name, age, sex, cash
    @portfolios = {}
  end

  def deposit_cash(cash)
    @cash += cash
  end

  def list_portfolios
    if @portfolios.empty?
      puts "You do not have any portfolios yet."
    else
      combined_value = 0
      puts "Your portfolios are worth:"
      @portfolios.each { |k,v|
        puts "#{k}: £#{v.calc_total_value}"
        combined_value += v.calc_total_value
      }
      puts "\nYour portfolios have a combined value of £#{combined_value}."
    end

  end

  def create_portfolio(name)
    @portfolios[name] = Portfolio.new(name)
  end

  def detailed_list_portfolio
  end


end
