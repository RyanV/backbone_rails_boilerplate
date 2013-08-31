#! /usr/bin/env ruby
$:.unshift(File.expand_path(__dir__))
require 'fileutils'
require './config/environment'
require './lib/rename/console_helper'
require './lib/rename/file_helper'

extend ConsoleHelper
extend FileHelper

def rename_class_reference file_path
  write(file_path, @old_class_name, @new_class_name)
end

def rename_underscore_reference file_path
  write(file_path, @old_name, @new_name)
end

@old_class_name = Rails.application.class.parent.to_s
@old_name = @old_class_name.underscore

@new_class_name = prompt('New application name')

if @new_class_name.blank?
  abort
else
  @new_class_name = @new_class_name.classify
end

@new_name = @new_class_name.underscore

rename_class_reference "config/application.rb"
rename_class_reference "config/environment.rb"
rename_class_reference "config/routes.rb"
rename_class_reference "config/environments/development.rb"
rename_class_reference "config/environments/production.rb"
rename_class_reference "config/environments/test.rb"
rename_class_reference "config/initializers/secret_token.rb"
rename_class_reference "config/initializers/session_store.rb"
rename_class_reference "Rakefile"

rename_underscore_reference 'config/database.yml'
rename_underscore_reference '.ruby-gemset'

remove_folder '.idea'
remove_folder '.git'

repo = Git.init
repo.add
repo.commit('first commit')
