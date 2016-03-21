class SearchController < ApplicationController
  def search

    #@pg_search_documents = PgSearch.multisearch(params[:search_input])
    eventsresult = []
    #eventsresult = Event.where("name LIKE ? OR content LIKE ?", "%#{params[:search_input]}%", "%#{params[:search_input]}%")
    @word = params[:search_input]
    eventsresult = eventsresult + Event.where("name ILIKE ? OR content ILIKE ?", "%#{@word}%", "%#{@word}%")



    @word = @word.split
    @word = @word.map {|val| "%#{val}%" }
    eventsresult = eventsresult + Event.where("name ILIKE ALL ( array[?] ) OR content ILIKE ALL ( array[?] )", @word, @word)
    #eventsresult = eventsresult + Event.where("name ILIKE ANY ( array[?] ) OR content ILIKE ANY ( array[?] )", @word, @word)
      #eventsresult = eventsresult + Event.where("name ILIKE ? OR content ILIKE ?", "%#{@word}%", "%#{@word}%")
      #infosresult = Info.where("name ILIKE ? OR content ILIKE ?", "%#{word}%", "%#{word}%")

    eventsresult.uniq!

    @events = eventsresult
    @infos = Info.last(2)

    @word = params[:search_input].split #Wichtig für Highlighter, muss am Ende sein
  end
end
