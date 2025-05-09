-- Toggle caps lock
hs.hotkey.bind({ "ctrl", "cmd", "alt" }, "P", function()
  hs.hid.capslock.toggle()
end)

-- Taken from Get TJ Miller's post:
-- https://medium.com/@sixlive/a-more-useful-caps-lock-15d6e0641e0b
send_escape = false
last_mods = {}

control_key_handler = function()
  send_escape = false
end

control_key_timer = hs.timer.delayed.new(0.15, control_key_handler)

control_handler = function(evt)
  local new_mods = evt:getFlags()
  if last_mods["ctrl"] == new_mods["ctrl"] then
    return false
  end
  if not last_mods["ctrl"] then
    last_mods = new_mods
    send_escape = true
    control_key_timer:start()
  else
    if send_escape then
      keyUpDown({}, "escape")
    end
    last_mods = new_mods
    control_key_timer:stop()
  end
  return false
end

control_tap = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, control_handler)
control_tap:start()

other_handler = function(evt)
  send_escape = false
  return false
end

other_tap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, other_handler)
other_tap:start()
