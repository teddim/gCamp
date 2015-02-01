class Faq

  def initialize(question,answer)
    @question = question
    puts "This is the model speaking...initializing"
    @answer = answer
    @slug = @question.gsub(" ","-")
  end

  def get_question
    return @question
  end

  def get_answer
    return @answer
  end

  def get_slug
    return @slug
  end
end
