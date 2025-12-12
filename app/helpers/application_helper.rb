module ApplicationHelper
  require "time"

  def locale_to_flag(locale)
    flags = {
      ru: "fi fi-ru",
      en: "fi fi-gb"
    }
    content_tag(:span, "", class: "flag-icon #{flags[locale.to_sym]}")
  end

  def format_time(time)
    return unless time.present?

    Time.parse(time).strftime("%H:%M")
  end

  def format_date(date)
    return unless date.present?

    time = Time.parse(date)
    I18n.l(time.to_date, format: :flight)
  end

  def format_duration(departure_utc, arrival_utc)
    return if departure_utc.blank? || arrival_utc.blank?

    departure_time = Time.parse(departure_utc)
    arrival_time = Time.parse(arrival_utc)

    total = ((arrival_time - departure_time) / 60).to_i
    hours, mins = total.divmod(60)

    [].tap do |parts|
      parts << "#{hours} #{I18n.t('flights.hours')}" if hours.positive?
      parts << "#{mins} #{I18n.t('flights.mins')}" if mins.positive?
    end.join(" ")
  end
end
