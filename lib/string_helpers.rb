class String

  def underscore
    gsub(' ', '_').gsub(/['.]/, '')
  end

end
