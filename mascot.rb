require 'csv'

class Mascot < Struct.new(:school, :name)

  extend ORMFromCSV

  class << self

    def all
      from_csv File.open('./mascots.csv')
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
