class String
  def markdown
    BlueCloth.new(self).to_html
  end

  def textile
    RedCloth.new(self).to_html
  end
end
