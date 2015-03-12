require 'csv'

class FilmRow
  attr_reader :name, :second_name, :gapoif,
    :time, :year, :kind, :url, :genres

  attr_writer :name, :second_name, :gapoif, :url

  def time=(time)
    @time = time.to_i
  end

  def year=(year)
    @year = year.to_i
  end

  def kind=(kind)
    if kind.length == 2
      name = Unicode.upcase(kind)
    else
      name = Unicode.capitalize(kind)
    end

    @kind = Kind.find_by(name: name)
  end

  def genres=(genres)
    @genres = genres.map do |g|
      name = Unicode.capitalize(g.strip)
      Genre.find_by(name: name)
    end
  end

  def genres_valid?
    genres && (genres.length == 0 || genres.exclude?(nil))
  end

  def save
    return :skipped if Film.find_by(url: url)

    if kind && genres_valid?
      Film.create!(
        name: name,
        second_name: second_name,
        mins: time,
        year: year,
        url: url,
        gapoif: gapoif,
        kind: kind,
        genres: genres
      )
      :added
    else
      # Refetch required
      return :invalid
    end
  end
end

namespace :import do
  desc 'Imports data from CSV file'
  task films: :environment do
    skipped = 0
    added = 0
    invalid = 0

    path = Rails.root.join('tmp/file.csv')
    if File.exists?(path)
      CSV.foreach(path) do |row|
        film = FilmRow.new
        film.name = row[0]
        film.second_name = row[1]
        film.gapoif = row[2]
        film.time = row[3]
        film.kind = row[4]
        film.url = row[5]
        film.year = row[6]

        film.genres = (row.last || '').strip.split(',')

        case film.save
        when :added
          added += 1
        when :skipped
          skipped += 1
        when :invalid
          invalid += 1
        end
      end

      puts ("\e[0;32;49mNew: #{added}\e[0m\t\e[0;33;49mOld: #{skipped}\e[0m\t\e[0;31;49mInvalid: #{invalid}\e[0m")
    else
      puts "Place CSV to the tmp/file.csv"
    end
  end
end
