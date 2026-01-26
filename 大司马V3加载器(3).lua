local function runOtherScript()
    local scriptUrl = "https://api.luarmor.net/files/v4/loaders/44ccf40792886c9b2119e541ebfbd62b.lua"
    pcall(function()
        loadstring(game:HttpGet(scriptUrl))()
    end)
end
runOtherScript()
