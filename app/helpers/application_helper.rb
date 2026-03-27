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

  def count_duration(departure_utc, arrival_utc)
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

  def format_duration(duration)
    return if duration.blank?

    if duration == 0
      "0 #{I18n.t('flights.hours')} 0 #{I18n.t('flights.mins')}"
    else
      hours, mins = duration.divmod(60)
      [].tap do |parts|
        parts << "#{hours} #{I18n.t('flights.hours')}" if hours.positive?
        parts << "#{mins} #{I18n.t('flights.mins')}" if mins.positive?
      end.join(" ")
    end
  end

  def format_total_duration(duration)
    return if duration.blank?

    if duration == 0
      "0 #{I18n.t('flights.hours')} 0 #{I18n.t('flights.mins')}"
    elsif duration < 60
      "#{duration} #{I18n.t('flights.mins')}"
    elsif duration >= 60 && duration < 1440
      hours, mins = duration.divmod(60)
      [].tap do |parts|
        parts << "#{hours} #{I18n.t('flights.hours')}" if hours.positive?
        parts << "#{mins} #{I18n.t('flights.mins')}" if mins.positive?
      end.join(" ")
    elsif duration >= 1440 && duration < 10080
      days, remain = duration.divmod(1440)
      hours, mins = remain.divmod(60)
      [].tap do |parts|
        parts << "#{days } #{I18n.t('.flights.dys')}" if days.positive?
        parts << "#{hours} #{I18n.t('flights.hrs')}" if hours.positive?
        parts << "#{mins} #{I18n.t('flights.mns')}" if mins.positive?
      end.join(" ")
    elsif duration >= 10080 && duration < 43200
      weeks, remain_one = duration.divmod(10080)
      days, remain_two = remain_one.divmod(1440)
      hours, mins = remain_two.divmod(60)
      [].tap do |parts|
        parts << "#{weeks } #{I18n.t('.flights.wks')}" if weeks.positive?
        parts << "#{days } #{I18n.t('.flights.dys')}" if days.positive?
        parts << "#{hours} #{I18n.t('flights.hrs')}" if hours.positive?
        parts << "#{mins} #{I18n.t('flights.mns')}" if mins.positive?
      end.join(" ")
    end
  end

  def around_earth(distance)
    (distance / 40075).round(2)
  end

  def to_moon(distance)
    (distance / 384400).round(2)
  end
end
