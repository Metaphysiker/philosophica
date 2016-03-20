class SearchController < ApplicationController
  def search
    @word = params[:search_input]
    #@pg_search_documents = PgSearch.multisearch(params[:search_input])
    q = "%#{params[:query]}%"

    eventsresult = Event.where("name LIKE ? OR content LIKE ?", "%#{params[:search_input]}%", "%#{params[:search_input]}%")
    infosresult = Info.where("name LIKE ? OR content LIKE ?", "%#{params[:search_input]}%", "%#{params[:search_input]}%")

    @events = eventsresult
    @infos = infosresult
  end
end
