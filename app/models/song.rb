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
    begin
      Chordpro.flexhtml(body).to_s
    rescue Parslet::ParseFailed => error
      '<div style="white-space: pre;font-family: mono">' + error.parse_failure_cause.ascii_tree + '</div>'
    end
  end

  def update(params)
    begin
      parsed = Chordpro::parse(params[:body])
    rescue Parslet::ParseFailed => error
      puts(error.parse_failure_cause.ascii_tree)
      return
    end
    metadata = parsed.metadata.to_h

    params[:title] = metadata["title"]
    params[:subtitle] = metadata["subtitle"]
    params[:artist] = metadata["artist"]

    super(params)
  end


  def chordpro
    "{title: #{title}}
{subtitle: #{subtitle}}
{artist: #{artist}}
#{body}"
  end
end
