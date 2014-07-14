require 'csv'
require 'json'

class Mascot < Struct.new(:school, :name, :tag)

  extend ORMFromCSV

  class << self

    # All mascots as grouped hash by year.
    def all
      @all ||= Dir['./db/*.csv'].each_with_object({}) do |file, hash|
        year = file.match(/(?<year>\d+)\.csv/)[:year].to_i
        hash[year] = from_csv File.open(file)
      end
    end

    # All unique tags as grouped hash by year.
    def tags
      return @tags if @tags
      @tags = all.each_with_object({}) do |(year, mascots), hash|
        hash[year] = mascots.map(&:tag).uniq.sort
      end
    end

    def compile_all!
      all_as_attributes = all.each_with_object({}) do |(year, mascots), hash|
        hash[year] = mascots.map(&:attributes)
      end
      json = JSON.pretty_generate(all_as_attributes)
      File.open("./public/javascripts/data.json", 'w') { |f| f.write json }
    end

  end

  attr_reader :attributes

  def initialize(attributes = {})
    @attributes = attributes
    @attributes.each do |field, value|
      send("#{field}=", value)
    end
  end

  def image_url
    "images/mascots/#{school.underscore.downcase}_#{name.underscore.downcase}.png"
  end

end
