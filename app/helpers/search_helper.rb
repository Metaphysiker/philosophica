module SearchHelper
  def wordmissing?(event, words)
    missingwords = []
    words.each do |word|
      if !(event.content.downcase().include? "#{word.downcase()}") && !(event.name.downcase().include? "#{word.downcase()}")
        missingwords.push(word)
      end
    end
    return missingwords
  end

  def stringswithwords(words, article)
    stringy = []
    allstrings = anymore?(article.content, words,stringy)
    return allstrings
  end

  def anymore2?(wholestring, substring,stringy)

    if doesitcontainany?(wholestring,substring)
      indexnum = indexoffirst(wholestring,substring)
      if indexnum <= 20
        stringy.push(wholestring.from(0).to(indexnum+20) + "...")
        wholestring = wholestring.from(indexnum+20)
        if !wholestring.nil?
          stringy.push(anymore?(wholestring, substring,stringy))
        end
        return stringy
      else
        stringy.push("..." + wholestring.from(0).to(indexnum+20) + "... \n")
        wholestring = wholestring.from(indexnum+20)
        if !wholestring.nil?
          stringy.push(anymore?(wholestring, substring,stringy))
        end
        return stringy
      end
    end

  end

  def anymore?(wholestring, substring,stringy)
    wholestring = sanitize(wholestring)
    if !(doesitcontainany?(wholestring,substring))
      stringy.push (strip_tags(wholestring.to(60)+ " ..."))
      return stringy
    end
    while doesitcontainany?(wholestring,substring)
      indexnum = indexoffirst(wholestring,substring)
logger.debug indexnum
      if indexnum > 20
        stringy.push(strip_tags("... " + wholestring.from(indexnum-20).to(60) + " ..."))
      else
        stringy.push(strip_tags(wholestring.from(0).to(60) + " ..."))
      end

      wholestring = wholestring.from(indexnum+20)
    end
    return stringy
  end

  def doesitcontainany?(wholestring,array)
    array.each do |element|

      if !(wholestring.nil?) && wholestring.downcase.include?(element.downcase)
        return true
      else
        return false
      end
    end
  end

  def indexoffirst(wholestring,array)
    wholestring = wholestring.downcase
    i = -1
    array.each do |element|
      if wholestring.include?(element.downcase)
        if i < wholestring.index(element.downcase)
          i = wholestring.index(element.downcase)
        end
      end
    end
    return i
  end

end
