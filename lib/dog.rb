class Dog
  attr_accessor :id, :name, :breed

  def initialize(name:nil, breed:nil, id:nil)
    @id = id
    @name = name
    @breed = breed
  end
end
