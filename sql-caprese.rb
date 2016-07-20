#practicing using SQL + Ruby for Challenge 8.5
#an app for logging pomodoros

#load gems

# create SQLite3 database

# create tables (if they don't already exist)
  #pomodoros table
    #should stuff be stored as hashes? it did make her code a bit more readable...memorizing indexes is annoying?
    #id => QUESTION: when you delete an entry, does its primary integer key get reassigned?
    #date - YYYY-MM-DD string? Maybe eventually write a module for
    #tags -> store as an array of strings? as one string? as an array of IDs -> refer to another table of tags?
    #description - string
  #tags table
    #ID
    #name - string

#Users should be able to
  #Add pomodoros
  #filter pomodoros by
    #date => date range
    #tag
      #need to write some method that splits up a list of tags

  #LAAAAAATER stuff
    #Edit pomodoros
      #
    #Delete pomodoros
