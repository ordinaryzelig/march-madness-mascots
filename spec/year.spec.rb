require 'spec_helper'

describe Year do

  it '.all returns all years in order' do
    Year.all.must_equal [2011, 2012]
  end

  it '.latest_year returns most current year' do
    Year.latest.must_equal 2012
  end

end
