#Some of this used from: https://github.com/appium/ruby_console/blob/master/osx_install.rake

def installed?(program)
  puts "`which #{program}`"
  #output = system "which #{program}"
  #puts output

  return true
  return output.match(/\S+/) != nil
end

def command(cmd)
  success = false
  begin
    success, status = sh cmd
  rescue
    # do nothing
  end

  success
end

#xCode Command Line Tools
GCC = '/usr/bin/gcc'
GCC42_CMD = 'gcc-4.2'
GCC42 = "/usr/local/bin/#{GCC42_CMD}"

file GCC do
  #Launching dialog then failing
  command 'xcode-select --install'
  fail "#{GCC} does not exist. This is likely because you do not have Xcode command line tools installed."
end

file GCC42 => [GCC] do
  command "ln -s #{GCC} #{GCC42}"
end

task :gcc do
  unless installed?('gcc-4.2')
    Rake::Task[GCC42].invoke
  end
end

task :java do
  #command "brew cask #{(installed?('java') ? 'upgrade' : 'install')} java"
end

task :postgres do
  #command "brew #{(installed?('postgres') ? 'upgrade' : 'install')} postgres"
end

task :redis do
  #command "brew #{(installed?('redis-server') ? 'upgrade' : 'install')} redis"
end

task :install => [:redis, :postgres, :gcc] do
  puts 'Done...'
end

task :default => :install