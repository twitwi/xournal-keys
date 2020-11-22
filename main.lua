-- Things I might want to add:
-- -ACTION_ROTATION_SNAPPING
-- -ACTION_GRID_SNAPPING
-- -ACTION_RULER (Does this toggle ruler, or is there a way to specify on/off?)
-- Register all Toolbar actions and intialize all UI stuff
function initUi()

  -- see key names at https://github.com/tindzk/GTK/blob/master/gdk/gdkkeysyms.h

  local s = {}
  -- s["a"] = "hand";
  -- s["g"] = "lasso";
  -- s["f"] = "pen";
  -- s["<Shift>f"] = "highlighter";
  -- s["r"] = "undo";
  -- s["<Shift>r"] = "redo";
  -- s["c"] = "copy";
  -- s["v"] = "paste";
  -- s["x"] = "cut";
  -- s["t"] = "delete";
  -- s["e"] = "eraser";
  -- s["s"] = "space";
  -- s["1"] = "Black";
  -- s["2"] = "Red";
  -- s["3"] = "Light_Green";
  -- s["w"] = "toggleruler"; -- blindly
  s["b"]      = "colorPrev"
  s["eacute"] = "colorNext"
  s["a"]      = "toolPrev"
  s["u"]      = "toolNext"
  s["x"]      = "copy"
  s["period"] = "paste"

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

local colorList = {
  {"black", 0x000000},
  {"green", 0x008000},
  {"lightblue", 0x00c0ff},
  {"lightgreen", 0x00ff00},
  {"blue", 0x3333cc},
  {"gray", 0x808080},
  {"red", 0xff0000},
  {"magenta", 0xff00ff},
  {"orange", 0xff8000},
  {"yellow", 0xffff00},
  {"white", 0xffffff}
}
local currentColor = 4 -- start with blue color
function colorStep(step)
  return function()
    currentColor = (currentColor + step - 1) % #colorList + 1
    app.changeToolColor({["color"] = colorList[currentColor][2], ["selection"] = true})
    print("Color: " .. colorList[currentColor][1])
  end
end
colorNext = colorStep(1)
colorPrev = colorStep(-1)

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

local toolList = {"PEN", "SELECTION", "RULER", "ERASER"} -- "HIGHLIGHTER"
local currentTool = 1
function toolStep(step)
  return function()
    currentTool = (currentTool + step - 1) % #toolList + 1
    if (toolList[currentTool] == "SELECTION") then
      app.uiAction({["action"] = "ACTION_TOOL_SELECT_RECT"})
      return
    end
    if (toolList[currentTool] == "RULER") then
      pen()
      ruler()
      return
    end
    noruler()
    app.uiAction({["action"] = "ACTION_TOOL_" .. toolList[currentTool]})
    noruler()
  end
end
toolNext = toolStep(1)
toolPrev = toolStep(-1)
