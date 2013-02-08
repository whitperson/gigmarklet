class HomeController < ApplicationController
  require 'open-uri'

  def index
  end

  def add_url
    @item_url = params[:item_url]
    doc = Nokogiri::HTML(open(@item_url))
      if @item_url.include?('ticketmaster.com')
        tm(doc)
      elsif @item_url.include?('livenation.com')
        ln(doc)
      elsif @item_url.include?('ticketfly.com')
        tf(doc)
      elsif @item_url.include?('axs.com')
        axs(doc)
      end
    binding.pry
    #    @auth.events << @event
    #   redirect_to @event
    # # redirect_to root_path
  end

  def tm(doc)
    link = @item_url
    artist = doc.css("div.artistDetails")[0].css("h1")[0].text
    venue = doc.css("span#artist_venue_name").children().text
    location = doc.css("span#artist_location").children().text
    event_date = doc.css("span#artist_event_date").children().text
    @event = Event.create(:link => link, :artist => artist, :venue => venue, :location => location, :event_date => event_date)
    @auth.events << @event
  end

  def ln(doc)
    link = @item_url
    artist = doc.css("h1.headliner").text
    event_date = (doc.css("div.date").css("div.month").text) + (doc.css("div.date").css("div.day").text) + (doc.css("div.date").css("div.year").text) + (doc.css("div.date").css("div.time").text)
    venue = doc.css("div.venue").css("div.name").text
    location = doc.css("div.venue").css("div.location").text
    @event = Event.create(:link => link, :artist => artist, :venue => venue, :location => location, :event_date => event_date)
    @auth.events << @event
  end

  def tf(doc)
    link = @item_url
    artist = doc.css("h1.headliners").text
    other_artists = doc.css("div.event-titles").css("h3").text
    event_date = (doc.css("div.event-date").css("p.event-date-day-of-week").text) + (doc.css("div.event-date").css("p.event-date-month").text) + (doc.css("div.event-date").css("p.event-date-day").text)
    venue = doc.css("div.event-venue.location.vcard").css("h5.venue.fn.org").text.squish
    location = doc.css("div.event-venue.location.vcard").css("p.city-state.adr").text
    @event = Event.create(:link => link, :artist => artist, :venue => venue, :location => location, :event_date => event_date)
    @auth.events << @event
  end

  def axs(doc)
    link = @item_url
    artist = doc.css("h1.edp_headliner").text
    other_artists = doc.css("div.edp_support").text.squish
    event_date = doc.css("div.edp_showtime").text
    venue = doc.css("div.edp_venue_name").text
    location = doc.css("div.edp_venue_address").text
    @event = Event.create(:link => link, :artist => artist, :venue => venue, :location => location, :event_date => event_date)
    @auth.events << @event
  end

end

