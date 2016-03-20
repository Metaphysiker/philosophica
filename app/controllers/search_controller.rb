class SearchController < ApplicationController
  def search
    #@pg_search_documents = PgSearch.multisearch(params[:search_input])
    q = "%#{params[:query]}%"

    eventsresult = Event.where("name LIKE ? OR content LIKE ?", "%#{params[:search_input]}%", "%#{params[:search_input]}%")

    @events = eventsresult
  end
end
