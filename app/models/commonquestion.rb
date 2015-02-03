class Commonquestion

  def initialize(question,answer)
    @question = question
    puts "This is the model speaking...initializing"
    @answer = answer
    @slug = @question.gsub(" ","-")

  end

  attr_reader :question
  attr_reader :answer
  attr_reader :slug


end
