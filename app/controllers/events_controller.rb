class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def create
    @event = Event.new(params[:item])
    if @event.save
      @auth.events << @event
      redirect_to @event
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event= Event.find(params[:id])
    if @event.update_attributes(params[:event])
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.delete
    redirect_to events_path
  end
end
