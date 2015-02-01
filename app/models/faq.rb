class Faq

  def initialize(question,answer)
    @question = question
    puts "This is the model speaking"
    puts "question:" + @question
    @answer = answer
    puts "answer:" + @answer
    @slug = @question.gsub(" ","-")
    puts "slug:" + @slug
  end

  def get_question
    p "HEY THIS IS THE MODEL SPEAKING"
    # p faq_array
    return @question
  end

  def get_answer
    return @answer
  end

  def get_slug
    #replace spaces with -
    return @slug
  end
end
