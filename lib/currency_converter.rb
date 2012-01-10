module CurrencyConverter

  def self.currencify(number, options={})
    # :currency_before => false puts the currency symbol after the number
    # default format: $12,345,678.90
    options = {:currency_symbol => "$", :delimiter => ",", :decimal_symbol => ".", :currency_before => true}.merge(options)
    
    # split integer and fractional parts
    int = (number/100).to_s
    frac = (number % 100).to_s
    frac = "0"*(2-frac.length)+frac
    # insert the delimiters
    int.gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{options[:delimiter]}")
    
    if options[:currency_before]
      options[:currency_symbol] + int + options[:decimal_symbol] + frac
    else
      int + options[:decimal_symbol] + frac + options[:currency_symbol]
    end
  end

end
