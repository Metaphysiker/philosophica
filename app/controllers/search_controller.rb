class SearchController < ApplicationController
  def search

    #@pg_search_documents = PgSearch.multisearch(params[:search_input])
    eventsresult = []
    infosresult = []
    #eventsresult = Event.where("name LIKE ? OR content LIKE ?", "%#{params[:search_input]}%", "%#{params[:search_input]}%")
    @word = params[:search_input].split
    @word.each do |word|
      eventsresult = eventsresult + Event.where("name ILIKE ? OR content ILIKE ?", "%#{word}%", "%#{word}%")
      infosresult = Info.where("name ILIKE ? OR content ILIKE ?", "%#{word}%", "%#{word}%")
    end

    eventsresult.uniq!
    infosresult.uniq!

    @events = eventsresult
    @infos = infosresult
  end
end
