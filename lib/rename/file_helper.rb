module FileHelper
  include ConsoleHelper

  def read file_path
    File.read file_path
  end

  def write file_path, old_name, new_name
    puts colorize("    rename : #{file_path}", :cyan)
    File.open(file_path, 'w') do |f|
      f.puts read(file_path).gsub(old_name, new_name)
    end
  end

  def remove_folder folder
    print "Delete folder #{folder}?: "
    if gets =~ /^y?/i
      puts colorize("    deleting : #{folder}", :yellow)
      FileUtils.rm_r folder
    end
  end
end
