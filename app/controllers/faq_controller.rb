class FaqController < ApplicationController

  def index
    p "HEY THIS IS THE CONTROLLER SPEAKING"

    @faq_array = [Faq.new("this is my question","a1"),Faq.new("this is my second question","a2"),Faq.new("this is my third question","a3")]
    # @test = Faq.new("q1","a1")
    @questions = @faq_array[1].get_question
  

    p "HEY THANKS MODEL, THIS IS THE CONTROLLER AGAIN"
  end

  def create
    @q1 = []
    @q1 = Faq.new
    p @q1
  end

end
