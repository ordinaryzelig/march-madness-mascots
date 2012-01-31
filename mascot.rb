require 'csv'

class Mascot < Struct.new(:school, :name, :tag)

  extend ORMFromCSV

  class << self

    def all
      @all ||= from_csv File.open('./mascots.csv')
    end

    def tags
      @tags ||= all.map(&:tag).uniq.sort
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
