module UsersHelper
  def id_format(string)
    return string.downcase.sub(' ','-')
  end
end
