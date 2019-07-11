# plex_schema
Experiment in examining my Plex sqlite schema, exporting into MySql and Object Modeling

I've been fiddling with version 8 of MySQL, and have always been a visual learner with databases.
So, I imported one of my old Plex Sqlite databases into SQLiteStudio, exported that as a .sql file then imported the accompanying 
tables, indexes, etc into MySQL. (This was pretty dirty, with > 200 syntax errors out of > 2100 lines of SQL I whacked through)
However, I finally got it to import with the plex3.sql file.
# plex3.sql 
I'm also including the unedited plexschema.sql file for anyone interested. 
I will probably use it against a Postgres instance sometime soon, and see how messy or clean that turns out.
After the MySQL import, I used the workbench and 'reverse engineered' this into a skeleton Object Relationship Model to get a better sense
of how the innards of my favorite media player works behind the scenes.
The smaller pdf of the same name of the high-res image below is also included if you ever want to play connect the dots;)
![Image ](/images/plex_object_relational_model_skeleton.jpg)
