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

#some test entries
db.execute("INSERT INTO pomodoros(pomDate, pomTime, tags,description) VALUES ('2016-07-19','1:30 PM', 'python','automate the boring stuff')")
db.execute("INSERT INTO pomodoros(pomDate, pomTime, tags,description) VALUES ('2016-07-20','2:30 PM','ruby','Sandi Metz book')")
db.execute("INSERT INTO tags(name) VALUES('python')")
db.execute("INSERT INTO tags(name) VALUES('ruby')")

#Users should be able to
  #Add pomodoros
    #some method that reads the tags and adds them to the tags table
  #View all pomodoros
  def view_all_poms(db)
    poms = db.execute("SELECT * FROM pomodoros")
    tags = db.execute("SELECT * FROM tags")
    poms.each do |pom|
      puts "#{pom['pomDate']} | #{pom['pomTime']} | #{pom['tags']} | #{pom['description']}"
    end
  end

  #filter pomodoros by
    #date => date range
    #tag
      #need to write some method that splits up a list of tags

#Somewhere down here will be a user interface

view_all_poms(db)

  #LAAAAAATER stuff
    #Edit pomodoros
      #
    #Delete pomodoros
