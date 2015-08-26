namespace :turf do
  desc "Create classes"
  task :create_classes do
    root = File.expand_path("../../", File.dirname(__FILE__))
    target = "#{Rake.original_dir}/config/turf/"
    FileUtils.mkdir_p(target)
    FileUtils.cp("#{root}/templates/*.rb", target)
  end
end
