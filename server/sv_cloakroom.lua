RegisterServerEvent("rsv_cloakroom:addoutfit")
AddEventHandler("rsv_cloakroom:addoutfit", function(outfit)
    local file = LoadResourceFile(GetCurrentResourceName(), "./data/"..string.gsub(GetPlayerIdentifierByType(source, "license"), "license:", "")..".json")
    local outfits = {}
    if file ~= nil then
        outfits = json.decode(file)
    end
    table.insert(outfits, outfit)
    SaveResourceFile(GetCurrentResourceName(), "./data/"..string.gsub(GetPlayerIdentifierByType(source, "license"), "license:", "")..".json", json.encode(outfits), -1)
end)

RegisterServerEvent("rsv_cloakroom:replaceoutfits")
AddEventHandler("rsv_cloakroom:replaceoutfits", function(outfits)
    SaveResourceFile(GetCurrentResourceName(), "./data/"..string.gsub(GetPlayerIdentifierByType(source, "license"), "license:", "")..".json", json.encode(outfits), -1)
end)

RegisterServerEvent("rsv_cloakroom:getoutfits")
AddEventHandler("rsv_cloakroom:getoutfits", function()
    local file = LoadResourceFile(GetCurrentResourceName(), "./data/"..string.gsub(GetPlayerIdentifierByType(source, "license"), "license:", "")..".json")
    local outfits = json.decode(file)
    TriggerClientEvent("rsv_cloakroom:sendoutfits", source, outfits)
end)