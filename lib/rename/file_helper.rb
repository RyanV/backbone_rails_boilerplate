module FileHelper
  include ConsoleHelper

  def read file_path
    File.read file_path
  end

  def write file_path, old_name, new_name
    puts colorize("    rename : #{file_path}", :cyan)
    data = read(file_path)
    File.open(file_path, 'w') do |f|
      f.puts data.gsub(old_name, new_name)
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
