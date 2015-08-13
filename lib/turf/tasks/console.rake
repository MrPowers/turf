desc "launches pry with turf environment loaded"
task :console do
  sh "pry -r ./lib/turf"
end
