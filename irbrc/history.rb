# Save History between irb sessions
desire('irb/ext/save-history') do
  IRB.conf[:SAVE_HISTORY] = 2500
  IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"
end
