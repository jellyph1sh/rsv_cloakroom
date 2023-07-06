fx_version "cerulean"
game "gta5"

version "1.0"
description "Cloakroom system linked to rsv_skin."
author "JellyPh1sh"

client_scripts {
    -- UI:
    "ui/RageUI.lua",
    "ui/uuid.lua",
    "ui/menu/*.lua",
    "ui/menu/functions/**/*.lua",
    "@rsv_skin/client/cl_skin.lua",
    "client/*.lua"
}

server_scripts {
    "server/*.lua"
}

shared_scripts {
    "shared/*.lua"
}

dependency "rsv_skin"