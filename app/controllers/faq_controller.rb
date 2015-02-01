class FaqController < ApplicationController

  def index
    @faq_array = [Faq.new("this is my question","a1"),
                  Faq.new("this is my second question","a2"),
                  Faq.new("this is my third question","a3")]
  end

end
