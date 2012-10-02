#
# RAILS
#

# Credit to http://quotedprintable.com/2007/9/13/my-irbrc
# Just for Rails...
if rails_env = ENV['RAILS_ENV']
  rails_root = File.basename(Dir.pwd)
  IRB.conf[:PROMPT] ||= {}
  IRB.conf[:PROMPT][:RAILS] = {
    :PROMPT_I => "#{rails_root}> ",
    :PROMPT_S => "#{rails_root}* ",
    :PROMPT_C => "#{rails_root}? ",
    :RETURN   => "=> %s\n"
  }
  IRB.conf[:PROMPT_MODE] = :RAILS

  # Called after the irb session is initialized and Rails has
  # been loaded (props: Mike Clark).
  IRB.conf[:IRB_RC] = Proc.new do
    begin
      ActiveRecord::Base.logger = Logger.new(STDOUT)
      ActiveRecord::Base.instance_eval { alias :[] :find }
    rescue NameError
      # ActiveRecord is not used
    end
  end
end
