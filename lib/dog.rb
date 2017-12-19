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

  def self.create(hash)
    dog = new(name:hash[:name], breed:hash[:breed])
    dog.save
    dog
  end

  def self.find_by_id(id)
    DB[:conn].execute("select * from dogs where id = #{id}")
  end

  def self.new_from_db(row)
    new(id:row[0], name:row[1], breed:row[2])
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
