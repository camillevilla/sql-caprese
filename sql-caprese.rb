#Ruby 2.1.5
#practicing using SQL + Ruby for Challenge 8.5
#an app for logging pomodoros

#load gems
require 'sqlite3'

# create SQLite3 database
db = SQLite3::Database.new("pomLog.db")
    #should stuff be stored as hashes? it did make her code a bit more readable...memorizing indexes is annoying?
db.results_as_hash = true

# create tables (if they don't already exist)
  #pomodoros table
  create_table_pom = <<-SQL
  CREATE TABLE IF NOT EXISTS pomodoros(
    id INTEGER PRIMARY KEY,
    pomDate VARCHAR(255),
    pomTime VARCHAR(255),
    tags VARCHAR(255),
    description VARCHAR(255)
  )
  SQL

  #tags table
  create_table_tags = <<-SQL
  CREATE TABLE IF NOT EXISTS tags(
    id INTEGER PRIMARY KEY,
    name VARCHAR(255)
  )
  SQL

db.execute(create_table_pom)
db.execute(create_table_tags)

# === METHOD DEFINITIONS ===
  # ADD pomodoros
  def add_pomodoro(db,pomDate,pomTime,tags,description)
    db.execute("INSERT INTO pomodoros (pomDate, pomTime, tags, description) VALUES (?,?,?,?)", [pomDate, pomTime, tags, description])
  end

  #split string of comma separated tags into an array
  #e.g. "ruby, book ,Pairing " => ['ruby','book','pairing']
  def parse_tags(tag_str)
    #split string into an array
    tags = tag_str.split(',')
    #Clean up tags
    tags.map do |tag|
      tag.strip!
      tag.downcase
    end
  end

  #later: read new pomodoro's tags. Add new ones to .tags table.

  # PRINT pomodoros info in a pretty format
  def pretty_print_poms(selection)
    selection.each do |pom|
      puts "#{pom['id']} | #{pom['pomDate']} | #{pom['pomTime']} | #{pom['tags']} | #{pom['description']}"
    end
  end

  # VIEW all pomodoros
  def view_all_poms(db)
    poms = db.execute("SELECT * FROM pomodoros")
    pretty_print_poms(poms)
  end

  # FILTER pomodoros by:
    #date
    def poms_by_date(db,pomDate)
      poms = db.execute("SELECT * FROM pomodoros WHERE pomDate=?", [pomDate])
      pretty_print_poms(poms)
    end

    #date range
    def poms_by_date_range(db,date1,date2)
      #BLARGH need some kind of date-parsing method to understand a string as a range
    end

    #id
    def poms_by_id(db,id)
      poms = db.execute("SELECT * FROM pomodoros WHERE id=?", [id])
      pretty_print_poms(poms)
    end

    #tag

  # EDIT pomodoros
    def edit_pom(db,id,attribute,value)
      case attribute
      when "date"
        db.execute("UPDATE pomodoros SET pomDate=? WHERE id=?", [value,id])
      when "time"
        db.execute("UPDATE pomodoros SET pomTime=? WHERE id=?", [value,id])
      when "tags"
        db.execute("UPDATE pomodoros SET tags=? WHERE id=?", [value,id])
      when "description"
        db.execute("UPDATE pomodoros SET tags=? WHERE id=?", [value,id])
      end
    end

# === USER INTERFACE ===
puts "TOMATOES EVERYWHAR!"
user_input = ''
while user_input != 'q'
  puts "\n[a]dd pomodoros | [v]iew pomodoros | | [e]dit pomodoro |[q]uit"
  user_input = gets.chomp
  #Add pomodoro
  if user_input =="a"
      puts "add"
  #View pomodoros
  elsif user_input == "v"
      puts "[va] View all | [vd] View by date | [id] View by id"
      user_input = gets.chomp
      #View all
      if user_input =="va"
        view_all_poms(db)
      #by single date
      elsif user_input =="vd"
        puts "Enter date (YYYY-MM-DD): "
        date = gets.chomp
        poms_by_date(db,date)
      #by ID
    elsif user_input =="id"
      puts "Enter pomodoro ID number: "
      id = gets.chomp
      poms_by_id(db,id)
      #by tag
      end
  #Edit pomodoro
  elsif user_input == 'e'
    puts "Enter pomodoro ID number:"
    id = gets.chomp
    poms_by_id(db,id)
    puts "Which attribute would you like to edit?"
    puts "date | time | tags | description"
    attribute = gets.chomp
    puts "Enter new value"
    value = gets.chomp
    edit_pom(db,id,attribute,value)
  end
end

# === DRIVER / TESTING CODE ===
#some test entries to populate the database
=begin
add_pomodoro(db,'2016-07-19','1:30 PM', 'python','automate the boring stuff')
add_pomodoro(db,'2016-07-20','2:30 PM','ruby','Sandi Metz book')
=end

#convert these to tests before extending tags and date methods
=begin
view_all_poms(db)

poms_by_date(db,"2016-07-19")
edit_pom(db,3,"time","3:30 PM")
poms_by_id(db,3)

db.execute("INSERT INTO tags(name) VALUES('python')")
db.execute("INSERT INTO tags(name) VALUES('ruby')")

p db.execute("SELECT * FROM pomodoros WHERE tags='nyet';") == []
p parse_tags("Python, ruby ,JAVASCRIPT ")
=end
