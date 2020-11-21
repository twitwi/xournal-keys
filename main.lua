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
--  s["w"] = "ruler";
  s["e"] = "eraser";
  s["s"] = "space";
  s["1"] = "black";
  s["2"] = "red";
  s["3"] = "green";

  for k,v in pairs(s) do
    app.registerUi({["menu"] = firstToUpper(v), ["callback"] = v, ["accelerator"] = k});
  end

end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function black()
	app.changeToolColor({["color"] = 0x000000, ["tool"] = "pen", ["selection"] = true})
end

function red()
	app.changeToolColor({["color"] = 0xff0000, ["tool"] = "pen", ["selection"] = true})
end

function green()
	app.changeToolColor({["color"] = 0x00ff00, ["tool"] = "pen", ["selection"] = true})
end

function hand()
  app.uiAction({["action"] = "ACTION_TOOL_HAND"})
end

function lasso()
  app.uiAction({["action"] = "ACTION_TOOL_SELECT_REGION"})
end

function pen()
  app.uiAction({["action"] = "ACTION_TOOL_PEN"})
end

function highlighter()
  app.uiAction({["action"] = "ACTION_TOOL_HILIGHTER"})
end

function undo()
  app.uiAction({["action"] = "ACTION_UNDO"})
end

-- This doesn't work?
function redo()
  app.uiAction({["action"] = "ACTION_REDO"})
end

function copy()
  app.uiAction({["action"] = "ACTION_COPY"})
end

function cut()
  app.uiAction({["action"] = "ACTION_CUT"})
end

function paste()
  app.uiAction({["action"] = "ACTION_PASTE"})
end

function delete()
  app.uiAction({["action"] = "ACTION_DELETE"})
end

function eraser()
  app.uiAction({["action"] = "ACTION_TOOL_ERASER"})
end

function space()
  app.uiAction({["action"] = "ACTION_TOOL_VERTICAL_SPACE"})
end

-- Disable this because it doesn't turn the ruler off again
-- function ruler()
--   app.uiAction({["action"] = "ACTION_RULER"})
-- end
