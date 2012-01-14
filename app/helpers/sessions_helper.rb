module SessionsHelper
  def title
    base_title = "Aplikasi TA/PA IT Telkom"
    if @title.nil?
      base_title
    else
      "#{@title} | #{base_title}"
    end
  end
end
