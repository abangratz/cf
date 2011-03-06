class RosterController < ApplicationController
  def show
    @characters = Character.all
  end
end
