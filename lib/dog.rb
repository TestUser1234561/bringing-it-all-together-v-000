class Dog
  attr_accessor :id, :name, :breed

  def initialize(name:nil, breed:nil, id:nil)
    @id = id
    @name = name
    @breed = breed
  end

  def self.create_table
    DB[:conn].execute(
      <<-SQL
        create table if not exists dogs (
          id integer primary key autoincrement,
          name text,
          breed text
        )
      SQL
    )
  end
end
