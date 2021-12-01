g_mEventHandlers["@ClientEval"] = function(playerId,event, source_id, target_id)
    if (not type(event) == "table") then
        Log("SKIPPED - Invalid event Data")
        return
    end
    if (not type(event.eval) == "string") then
        Log("eval string not found")
        return
    else
        local result
        Log("Client Eval >>")
        local eval_string = event.eval
        Log("   eval_string: " .. eval_string)

        if result then
            return result
        end
    end
end
