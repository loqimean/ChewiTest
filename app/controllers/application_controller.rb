class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    [params[:locale], extract_locale, I18n.default_locale].each do |l|
      if l && I18n.available_locales.index(l.to_sym)
        I18n.locale = l
        break
      end
    end
  end

  def extract_locale
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first if request.env['HTTP_ACCEPT_LANGUAGE']
  end
end
