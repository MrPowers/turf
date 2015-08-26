namespace :turf do
  desc "Create classes configuration classes to setup Turf"
  task :setup do
    root = File.expand_path("../../", File.dirname(__FILE__))
    target = "#{Rake.original_dir}/config/turf/"
    FileUtils.mkdir_p(target)
    `cp -n #{root}/templates/*.rb #{target}`
  end
end
