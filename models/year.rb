class Year

  class << self

    def all
      Mascot.all.keys.sort
    end

    def latest
      all.last
    end

  end

end
