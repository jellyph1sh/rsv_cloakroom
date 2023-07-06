local plyOutfits = {}

RegisterNetEvent("rsv_cloakroom:sendoutfits")
AddEventHandler("rsv_cloakroom:sendoutfits", function(sOutfits)
    plyOutfits = sOutfits
end)

function OutfitsItems(items)
    if #plyOutfits == 0 then
        items:Separator("You don't have any outfits.")
        return
    end
    local outfitsNames = {}
    for _, outfit in pairs(plyOutfits) do
        table.insert(outfitsNames, outfit.name)
    end
    items:List("Outfits", outfitsNames, outfitsIdx, nil, {}, true, {
        onListChange = function(idx, item)
            outfitsIdx = idx
        end
    })
    items:Button("Apply", "", {}, true, {
        onSelected = function()
            ApplyClothes(plyOutfits[outfitsIdx])
            cloakroomMenu:close()
        end
    })
    items:Button("Rename", "", {}, true, {
        onSelected = function()
            RenameOutfit(plyOutfits, outfitsIdx)
            cloakroomMenu:close()
        end
    })
    items:Button("Delete", "", {}, true, {
        onSelected = function()
            RemoveOutfit(plyOutfits, outfitsIdx)
            cloakroomMenu:close()
        end
    })
end

function AddOutfit()
    local outfit = SaveClothes()
    outfit.name = exports.rsv_utils:InputText("FMMC_KEY_TIP9N", 15)
    TriggerServerEvent("rsv_cloakroom:addoutfit", outfit)
end

function RenameOutfit(outfits, idx)
    outfits[idx].name = exports.rsv_utils:InputText("FMMC_KEY_TIP9N", 15)
    TriggerServerEvent("rsv_cloakroom:replaceoutfits", outfits)
end

function RemoveOutfit(outfits, idx)
    table.remove(outfits, idx)
    TriggerServerEvent("rsv_cloakroom:replaceoutfits", outfits)
end

function CloakroomMenu(haveSave)
    cloakroomMenu = RageUI.CreateMenu("Cloakroom", "~b~Your cloakroom!")
    save = haveSave
    cloakroomMenu.Closable = not save
    cloakroomMenu.EnableMouse = false

    local appearanceMenu = RageUI.CreateSubMenu(cloakroomMenu, "Appearance", "~b~Change your appearance!")
    local outfitsMenu = RageUI.CreateSubMenu(cloakroomMenu, "Yours Outfits", "~b~All of yours outfits!")
    dIndexes = GetAllDrawablesIndexes()
    pIndexes = GetAllPropsIndexes()
    cloakroomMenu:isVisible(function(items)
        dIndexes = GetAllDrawablesIndexes()
        pIndexes = GetAllPropsIndexes()
        items:Button("Your appearance", "~b~Change your appearance!", {}, true, {}, appearanceMenu)
        items:Button("Save this outfit", "~b~Save actual outfit!", {LeftBadge = RageUI.BadgeStyle.Tick}, true, {
            onSelected = function()
                AddOutfit()
                cloakroomMenu:close()
            end
        })
        items:Button("Your outfits", "~b~See your outfits!", {}, true, {}, outfitsMenu)
    end)
    appearanceMenu:isVisible(ClothesItems)
    outfitsIdx = 1
    outfitsMenu:isVisible(OutfitsItems)
    return cloakroomMenu
end

local cloakroom 

function SpawnConnectedPlayer()
    while (not NetworkIsPlayerActive(PlayerId())) do
        Wait(100)
    end

    cloakroom = CloakroomMenu(false)
end

RegisterCommand("cloakroom", function()
    TriggerServerEvent("rsv_cloakroom:getoutfits")
    cloakroom:toggle()
end)

SpawnConnectedPlayer()