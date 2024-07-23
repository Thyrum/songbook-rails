class Song < ApplicationRecord
  def header
    if artist.present?
      "#{title} - #{artist}"
    else
      title
    end
  end

  def html
    Chordpro.html(body)
  end

  def chordpro
    "{title: #{title}}
{subtitle: #{subtitle}}
{artist: #{artist}}
#{body}"
  end

end
