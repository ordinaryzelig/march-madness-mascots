require 'csv'

class Mascot < Struct.new(:school, :name, :tag)

  extend ORMFromCSV

  class << self

    def all
      @all ||= Dir['./db/*.csv'].each_with_object({}) do |file, hash|
        year = file.match(/(?<year>\d+)\.csv/)[:year].to_i
        hash[year] = from_csv File.open(file)
      end
    end

    def tags
      @tags ||= all.map do |_, mascots|
        mascots.map(&:tag)
      end.flatten.uniq.sort
    end

    def years
      all.keys.sort
    end

    def latest_year
      years.last
    end

  end

  def initialize(atts = {})
    atts.each do |field, value|
      send("#{field}=", value)
    end
  end

  def image_url
    "images/mascots/#{school.underscore.downcase}_#{name.underscore.downcase}.png"
  end

end
