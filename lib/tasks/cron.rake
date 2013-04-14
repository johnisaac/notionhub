desc "This task is run once a day to reindex the DB"
task :cron => :environment do
 if Time.now.hour == 0 # run once a day
   puts "Reindexing DB..."
   Rake::Task["sunspot:reindex"].invoke
   puts "done."
 end
end
