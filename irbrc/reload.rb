# Load / reload files faster
# http://www.themomorohoax.com/2009/03/27/irb-tip-load-files-faster
def fl(file_name)
  file_name += '.rb' unless file_name =~ /\.rb/
  @@recent = file_name
  load "#{file_name}"
end

def rl
  fl(@@recent)
end

# Reload the file and try the last command again
# http://www.themomorohoax.com/2009/04/07/ruby-irb-tip-try-again-faster
def rt
  rl
  eval(choose_last_command)
end

# prevent 'rt' itself from recursing.
def choose_last_command
  real_last = Readline::HISTORY.to_a[-2]
  real_last == 'rt' ? @@saved_last :  (@@saved_last = real_last)
end
