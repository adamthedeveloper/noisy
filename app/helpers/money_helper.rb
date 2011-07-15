module MoneyHelper
  def cents_to_currency(cents)
    number_to_currency((cents.to_f)/100)
  end
end