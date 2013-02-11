class HomeController < ApplicationController
  require 'open-uri'

  def index
  end

  def add_url
    @url = params[:url]
    event = Event.new
    event.parse(@url)
    # @url = params[:url]
    # doc = Nokogiri::HTML(open(@url))
    #   if @url.include?('ticketmaster.com')
    #     tm(doc)
    #   elsif @url.include?('livenation.com')
    #     ln(doc)
    #   elsif @url.include?('ticketfly.com')
    #     tf(doc)
    #   elsif @url.include?('axs.com')
    #     axs(doc)
    #   end
    # binding.pry
    #    @auth.events << @event
    #   redirect_to @event
    # # redirect_to root_path
  end

end
