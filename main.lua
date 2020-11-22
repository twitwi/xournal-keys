-- Things I might want to add:
-- -ACTION_ROTATION_SNAPPING
-- -ACTION_GRID_SNAPPING
-- -ACTION_RULER (Does this toggle ruler, or is there a way to specify on/off?)
-- Register all Toolbar actions and intialize all UI stuff
function initUi()

  -- see key names at https://github.com/tindzk/GTK/blob/master/gdk/gdkkeysyms.h

  local s = {}
  s["a"] = "hand";
  s["g"] = "lasso";
  s["f"] = "pen";
  s["<Shift>f"] = "highlighter";
  s["r"] = "undo";
  s["<Shift>r"] = "redo";
  s["c"] = "copy";
  s["v"] = "paste";
  s["x"] = "cut";
  s["t"] = "delete";
  s["e"] = "eraser";
  s["s"] = "space";
  s["1"] = "Black";
  s["2"] = "Red";
  s["3"] = "Light_Green";
  s["w"] = "toggleruler"; -- blindly

  for k,v in pairs(s) do
    app.registerUi({["menu"] = firstToUpper(v), ["callback"] = v, ["accelerator"] = k});
  end

end

function act(a)
  return function()
    app.uiAction({["action"] = a})
  end
end

function color(c)
  return function()
    app.changeToolColor({["color"] = c, ["tool"] = "pen", ["selection"] = true})
  end
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

-- see color names at https://github.com/xournalpp/xournalpp/blob/master/src/gui/toolbarMenubar/model/ToolbarColorNames.cpp

Black = color(0x000000)
Green = color(0x008000)
Light_Blue = color(0x00c0ff)
Light_Green = color(0x00ff00)
Blue = color(0x3333cc)
Gray = color(0x808080)
Red = color(0xff0000)
Magenta = color(0xff00ff)
Orange = color(0xff8000)
Yellow = color(0xffff00)
White = color(0xffffff)

-- see actions at https://github.com/xournalpp/xournalpp/blob/master/src/enums/ActionType.enum.h

hand = act("ACTION_TOOL_HAND")
lasso = act("ACTION_TOOL_SELECT_REGION")
pen = act("ACTION_TOOL_PEN")
highlighter = act("ACTION_TOOL_HILIGHTER")
undo = act("ACTION_UNDO")
redo = act("ACTION_REDO")
copy = act("ACTION_COPY")
cut = act("ACTION_CUT")
paste = act("ACTION_PASTE")
delete = act("ACTION_DELETE")
eraser = act("ACTION_TOOL_ERASER")
space = act("ACTION_TOOL_VERTICAL_SPACE")
ruler = act("ACTION_RULER")
function noruler()
    app.uiAction({["action"] = "ACTION_RULER", ["enabled"] = false})
end
hasRuler = false
function toggleruler()
    ruler = not hasRuler
    app.uiAction({["action"] = "ACTION_RULER", ["enabled"] = hasRuler})
end

