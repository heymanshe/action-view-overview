require "ostruct"

class PeopleController < ApplicationController
  def show
    @person = OpenStruct.new(name: "David Heinemeier Hansson", bio: "A product of Danish Design during the Winter of '79...")

    respond_to do |format|
      format.xml
    end
  end
end
