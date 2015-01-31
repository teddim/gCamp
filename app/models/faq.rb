class Faq < ActiveRecord::Base

  def initialize(question,answer,slug)
    @question = question
    puts "This is the model speaking"
    @answer = answer
    @slug = slugs
  end

  def self.get_question(faq_array)
    p "HEY THIS IS THE MODEL SPEAKING"
    return faq_array[0]
  end

  def self.answer(id)
    return id
  end

  def self.slugs(answer)
    #replace spaces with -
    return answer
  end
end
