module SearchHelper
  def wordmissing?(event, words)
    missingwords = []
    words.each do |word|
      if !(event.content.downcase().include? "#{word.downcase()}") && !(event.name.downcase().include? "#{word.downcase()}")
        missingwords.push(word)
        Rails.logger.debug("missingwords" + word.inspect)
        Rails.logger.debug("missingwords" + missingwords.inspect)
      end
    end
    return missingwords
  end
end
