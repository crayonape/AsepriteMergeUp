function merge_up()
  local lay = app.layer

  if not lay then return app.alert "Select an active layer" end

  app.transaction(
     function()
       app.command.GotoNextLayer()
       local name = app.layer.name
       app.command.MergeDownLayer()
       app.layer.name = name
     end)
end


function has_next()
  local has = true

  if app.layer.isGroup or app.layer.stackIndex == #app.layer.parent.layers then has = false end

  return has
end


function init(plugin)
  plugin:newCommand{
    id="MergeUp",
    title="Merge Up",
    group="layer_popup_merge",
    onclick=function()
      merge_up()
    end,
    onenabled=function()
      return has_next()
    end
  }
end