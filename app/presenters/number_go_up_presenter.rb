# frozen_string_literal: true

class NumberGoUpPresenter
  def self.emoji(ngu)
    return '' unless ngu.present?

    case ngu
    when 0 .. 1
      '🧘'
    when 1..(1.5)
      '👏'
    when 1.5 .. 2
      '😎'
    when 2..3
      '🥳'
    when 3..4
      '🏅'
    when 4..5
      '🏆'
    when 5..6
      '🤩'
    when 6..10
      '📈'
    when 10..15
      '🔥'
    when 15..20
      '👑'
    when 20..30
      '🚀'
    else
      '⚜️'
    end
  end
end
