class Collaborator
  attr_reader :login

  def initialize(data)
    @login = data[:login]
  end
end
