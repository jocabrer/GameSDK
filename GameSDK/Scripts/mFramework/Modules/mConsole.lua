local console_colours = {
  redText = '$3',
  greenText = '$4',
  blueText = '$5'
}
write_log = function(Message)
  return Log("        " .. tostring(Message))
end
write_succes = function(Message)
  local greenText
  greenText = console_colours.greenText
  return Log(tostring(greenText) .. "      > " .. tostring(Message))
end
write_warn = function(Message)
  local blueText
  blueText = console_colours.blueText
  return Log(tostring(blueText) .. "      > " .. tostring(Message))
end
write_error = function(Message)
  local redText
  redText = console_colours.redText
  return Log(tostring(redText) .. "      > " .. tostring(Message))
end
local mConsole = {
  console_colours = console_colours,
  write_log = write_log,
  write_succes = write_succes,
  write_warn,
  write_error = write_error
}

RegisterModule("mFramework.ConsoleHelper",mConsole)