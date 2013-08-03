class RenameTask
  attr_reader :new_name

  def initialize options
    @new_name = options[:new_name].classify
  end

  def old_name
    @old_name ||= Rails.application.class.parent.to_s
  end

  def rename_class filepath
    data = File.read filepath
    File.open(filepath, 'w') do |f|
      f.puts data.gsub /#{Regexp.escape old_name}/, new_name
    end
  end

  def rename_underscore_refs filepath
    data = File.read filepath
    File.open(filepath, 'w') do |f|
      f.puts data.gsub /#{Regexp.escape old_name.underscore}/, new_name.underscore
    end
  end
end

desc "renames application"
task :rename, [:new_name] => :environment do |t, args|
  task = RenameTask.new(args)
  task.rename_class "config/application.rb"
  task.rename_class "config/environment.rb"
  task.rename_class "config/routes.rb"
  task.rename_class "config/environments/development.rb"
  task.rename_class "config/environments/production.rb"
  task.rename_class "config/environments/test.rb"
  task.rename_class "config/initializers/secret_token.rb"
  task.rename_class "config/initializers/session_store.rb"
  task.rename_class "Rakefile"

  task.rename_underscore_refs 'config/database.yml'
  task.rename_underscore_refs '.ruby-gemset'
end
