class ApplicationController < ActionController::Base
  before_action :set_locale

  private

    def set_locale
      client_locales = [params[:locale], extract_locale, I18n.default_locale]

      client_locales.each do |locale|
        if locale && I18n.available_locales.include?(locale.to_sym)
          I18n.locale = locale
          break
        end
      end
    end

    def extract_locale
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first if request.env['HTTP_ACCEPT_LANGUAGE']
    end
end
