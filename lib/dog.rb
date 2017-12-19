class Dog
  attr_accessor :id, :name, :breed

  def initialize(name:nil, breed:nil, id:nil)
    @id = id
    @name = name
    @breed = breed
  end

  def save
    DB[:conn].prepare("insert into dogs (name, breed) values (?, ?)").execute([self.name, self.breed])
    self.id = DB[:conn].execute('select max(id) from dogs')[0][0]
    self
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

  def self.drop_table
    DB[:conn].execute("drop table dogs")
  end
end
