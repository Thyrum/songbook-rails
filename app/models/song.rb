class Song < ApplicationRecord
  validates_each :body do |record, attr, value|
    begin
      Chordpro::parse(record.body)
    rescue Parslet::ParseFailed => error
      record.errors.add(attr, error.parse_failure_cause.ascii_tree)
      puts(error.parse_failure_cause.ascii_tree)
    end
  end

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
