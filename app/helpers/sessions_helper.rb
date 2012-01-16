module SessionsHelper
  def title
    base_title = "Aplikasi TA/PA IT Telkom"
    if @title.nil?
      base_title
    else
      "#{@title} | #{base_title}"
    end
  end

  def sign_in(lecture)
    cookies.permanent.signed[:remember_token] = [lecture.id, lecture.salt]
    current_lecture = lecture
  end

end
