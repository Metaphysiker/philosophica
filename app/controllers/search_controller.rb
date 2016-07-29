class SearchController < ApplicationController
  def search

    #@pg_search_documents = PgSearch.multisearch(params[:search_input])

    #eventsresult = Event.where("name LIKE ? OR content LIKE ?", "%#{params[:search_input]}%", "%#{params[:search_input]}%")
    inputword = params[:search_input]



    #@word = @word.map {|val| "%#{val}%" }


    #eventsresult = eventsresult + Event.where("name ILIKE ALL ( array[?] ) OR content ILIKE ALL ( array[?] )", @word, @word)
    #eventsresult = eventsresult + Event.where("name ILIKE ANY ( array[?] ) OR content ILIKE ANY ( array[?] )", @word, @word)
      #eventsresult = eventsresult + Event.where("name ILIKE ? OR content ILIKE ?", "%#{@word}%", "%#{@word}%")
      #infosresult = Info.where("name ILIKE ? OR content ILIKE ?", "%#{word}%", "%#{word}%")

    @events = searchin(Event,inputword)
    @infos = searchin(Info, inputword)

    @word = params[:search_input].split #Wichtig für Highlighter, muss am Ende sein
  end
end

private

def searchin (klass, input)
  classresult = klass.where("name ILIKE ? OR content ILIKE ?", "%#{input}%", "%#{input}%")
  input = input.split

  classresult = findwithamount(input, input.length, classresult)

  if input.length >=2
    classresult = findwithamount(input, input.length-1, classresult)
  end

  if input.length >=1
    classresult = findwithamount(input, input.length-2, classresult)
  end
  classresult.uniq!
  return classresult
end

def findwithamount(array, number, list)
  midresult = []
  highresult = []
  array.each do |word|
    localresult= Event.where("name ILIKE ? OR content ILIKE ?","%#{word}%", "%#{word}%")
    midresult = midresult + localresult #enthält alle Events mit mindestens einem Wort
  end
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