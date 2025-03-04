CallbackResponses = {}
local requestId = 0

Core.Functions.TriggerServerCallback = function(name, cb, ...)
    requestId = requestId + 1
    CallbackResponses[requestId] = cb
    TriggerServerEvent('kCore:triggerCallback', name, requestId, ...)
end


RegisterNetEvent('kCore:callbackResponse', function(requestId, ...)
    if source ~= 65535 then return end -- if not server
    local cb = CallbackResponses[requestId]
    if cb then
        cb(...)
        CallbackResponses[requestId] = nil
    end
end)

exports('TriggerServerCallback', Core.Functions.TriggerServerCallback)
