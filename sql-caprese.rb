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

#Users should be able to
  #Add pomodoros
  def add_pomodoro(db,pomDate,pomTime,tags,description)
    db.execute("INSERT INTO pomodoros (pomDate, pomTime, tags, description) VALUES (?,?,?,?)", [pomDate, pomTime, tags, description])
    #some method that reads the tags and adds them to the tags table
  end

  #GAH all this ugly repetitive code. Eventually refactor and separate pretty print into a separate method.
  #View all pomodoros
  def view_all_poms(db)
    poms = db.execute("SELECT * FROM pomodoros")
    poms.each do |pom|
      puts "#{pom['id']} | #{pom['pomDate']} | #{pom['pomTime']} | #{pom['tags']} | #{pom['description']}"
    end
  end

  #filter pomodoros by  
    #date
    def poms_by_date(db,pomDate)
      poms = db.execute("SELECT * FROM pomodoros WHERE pomDate=?", [pomDate])
      poms.each do |pom|
        puts "#{pom['id']} | #{pom['pomDate']} | #{pom['pomTime']} | #{pom['tags']} | #{pom['description']}"
      end
    end

    #date range
    def poms_by_date_range(db,date1,date2)
      #BLARGH need some kind of date-parsing method to understand a string as a range
    end
    #tag
      #need to write some method that splits up a list of tags

  #explore individual pomodoro
 

  #LAAAAAATER stuff
    #Edit pomodoros
    #Delete pomodoros

#Somewhere down here will be a user interface
  #[v]iew range
    #[d]ate
    #[t]ag
    #[i]d
      #[n]ext
      #[p]revious
  #[a]dd

#driver code for testing
add_pomodoro(db,'2016-07-19','1:30 PM', 'python','automate the boring stuff')
add_pomodoro(db,'2016-07-20','2:30 PM','ruby','Sandi Metz book')
view_all_poms(db)
poms_by_date(db,"2016-07-19")
poms_by_id(db,3)
db.execute("INSERT INTO tags(name) VALUES('python')")
db.execute("INSERT INTO tags(name) VALUES('ruby')")


