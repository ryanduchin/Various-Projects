desc 'Prune old URLS'
task :prune => :environment do
  ShortenedUrl.prune
end
