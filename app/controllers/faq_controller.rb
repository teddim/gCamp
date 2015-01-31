class FaqController < ApplicationController

  def index
    p "HEY THIS IS THE CONTROLLER SPEAKING"
    faq_array = []
    faq_array = ["4","2"]
    @questions = Faq.get_question(faq_array)

    p "HEY THANKS MODEL, THIS IS THE CONTROLLER AGAIN"
  end



end
