class SearchController < ApplicationController
  def search

    #@pg_search_documents = PgSearch.multisearch(params[:search_input])

    #eventsresult = Event.where("name LIKE ? OR content LIKE ?", "%#{params[:search_input]}%", "%#{params[:search_input]}%")
    inputword = params[:search_input]
    Rails.logger.debug("params2:" + inputword.inspect)
    eventsresult = Event.where("name ILIKE ? OR content ILIKE ?", "%#{inputword}%", "%#{inputword}%")

    Rails.logger.debug("inputword: " +inputword)
    inputword = inputword.split
    Rails.logger.debug(inputword.inspect)

    eventsresult = findwithamount(inputword, inputword.length, eventsresult)

    if inputword.length >=2
      eventsresult = findwithamount(inputword, inputword.length-1, eventsresult)
    end

    if inputword.length >=1
      eventsresult = findwithamount(inputword, inputword.length-2, eventsresult)
    end
    #@word = @word.map {|val| "%#{val}%" }


    #eventsresult = eventsresult + Event.where("name ILIKE ALL ( array[?] ) OR content ILIKE ALL ( array[?] )", @word, @word)
    #eventsresult = eventsresult + Event.where("name ILIKE ANY ( array[?] ) OR content ILIKE ANY ( array[?] )", @word, @word)
      #eventsresult = eventsresult + Event.where("name ILIKE ? OR content ILIKE ?", "%#{@word}%", "%#{@word}%")
      #infosresult = Info.where("name ILIKE ? OR content ILIKE ?", "%#{word}%", "%#{word}%")
    eventsresult.uniq!
    @events = eventsresult
    @infos = Info.last(2)

    @word = params[:search_input].split #Wichtig für Highlighter, muss am Ende sein
  end
end

private

def findwithamount(array, number, list)
  midresult = []
  highresult = []
  array.each do |word|
    localresult= Event.where("name ILIKE ? OR content ILIKE ?","%#{word}%", "%#{word}%")
    midresult = midresult + localresult #enthält alle Events mit mindestens einem Wort
  end
  Rails.logger.debug("midresult:" + midresult.inspect)
  midresult.each do |mid|
    i = 0
    midresult.each do |mid2|
      if mid == mid2
        i = i + 1
      end
    end
    if i == number
      highresult.push(mid)
    end
  end


    list = list + highresult
    return list
end