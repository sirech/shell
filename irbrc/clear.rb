# Clear the screen
def clear
  system 'clear'
  if ENV['RAILS_ENV']
    return "Rails environment: " + ENV['RAILS_ENV']
  else
    return "No rails environment - happy hacking!";
  end
end

# Shortcuts
alias c clear
