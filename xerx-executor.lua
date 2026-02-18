local TOKEN = "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"
local RAW_URL = "https://raw.githubusercontent.com/arcparagon/roblox-ui/refs/heads/main/xerx-universal.lua"

local function loadPrivateScript()
    local success, result = pcall(function()
        if request or http_request or (syn and syn.request) then
            local reqFunc = request or http_request or syn.request
            local response = reqFunc({
                Url = RAW_URL,
                Method = "GET",
                Headers = {
                    ["Authorization"] = "token " .. TOKEN,
                    ["Accept"] = "application/vnd.github.v3.raw"
                }
            })
            if response.StatusCode == 200 then
                return response.Body
            else
                warn("[XERX] Failed to fetch script. Status: " .. tostring(response.StatusCode))
                return nil
            end
        else
            return game:HttpGet(RAW_URL)
        end
    end)

    if success and result then
        local exec, err = loadstring(result)
        if exec then
            exec()
        else
            warn("[XERX] Loadstring error: " .. tostring(err))
        end
    else
        warn("[XERX] Request failed: " .. tostring(result))
    end
end

loadPrivateScript()
