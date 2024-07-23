class Song < ApplicationRecord
  def header
    if artist.present?
      "#{title} - #{artist}"
    else
      title
    end
  end
end
