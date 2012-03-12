require 'spec_helper'

describe Mascot do

  it '.all loads all mascots from each year in db/*.csv files.' do
    mascots = Mascot.all
    mascots.must_be_kind_of Hash
    mascots[2011].must_be_kind_of Array
    mascots[2011].size.must_equal 68
  end

  it '.tags returns array of unique tags' do
    tags = Mascot.tags[2011]
    tags.wont_be_empty
    tags.size.must_equal tags.uniq.size
  end

end