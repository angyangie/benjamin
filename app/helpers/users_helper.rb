module UsersHelper
  def id_format(string)
    newstring = string.sub(' & ','-')
    return newstring.downcase.sub(' ','-')
  end

  def display_amount(month, key)
    x = month[month.keys.first][key]
    !x.nil? ? number_to_currency(x, {precision: 0, negative_format: "(%u%n)"}) : "$0"
  end
end
