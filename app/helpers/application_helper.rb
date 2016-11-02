# rubocop:disable Metrics/LineLength
module ApplicationHelper

  def time_ago(time)
    now = Time.now
    if now.year > time.year
      time.strftime('%d/%m/%y')
    else
      case (now - time)
      when 0..43_200 then time_ago_in_words(time).gsub('about', '')
      when 43_201..86_400 then 'today'
      when 86_401..172_800 then 'yesterday'
      when 172_801..864_000 then time_ago_in_words(time).gsub('about', '') + ' (' + time.strftime('%b %d') + ')'
      else time.strftime('%b %d')
      end
    end
  end

  def time_ago_short(time)
    now = Time.now
    if now.year > time.year
      time.strftime('%d/%m/%y')
    else
      case (now - time)
      when 0..43_200 then time_ago_in_words(time).gsub('about', '')
      when 43_201..86_400 then 'today'
      when 86_401..172_800 then 'yesterday'
      when 172_801..864_000 then time_ago_in_words(time).gsub('about', '')
      else time.strftime('%b %d')
      end
    end
  end

end
