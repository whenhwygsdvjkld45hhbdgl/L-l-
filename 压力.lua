local old = game.HttpGet

local link = {
["https://pastebin.com/raw/HewqsY9N"] = "https://pastebin.com/raw/r0St595V"
}

local HttpMethod = newcclosure(function(self, url, ...)
    if link[url] then
        url = link[url]
    end
    return old(self, url, ...)
end)

local old
old = hookmetamethod(game, "__index", newcclosure(function(self, key)
    if checkcaller() and self == game and key == "HttpGet" then
        return HttpMethod
    end
    return old(self, key)
end))
task.wait()
loadstring(game:HttpGet("https://raw.githubusercontent.com/lyyanai/lol/refs/heads/main/12552538292"))()
while true do
task.wait()
game:GetService("CoreGui")["frosty is cute"].Main.SB.Side.ScriptTitle.Text = "大司马脚本 | 压力"
end