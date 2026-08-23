-- VoidHub main loader

local BASE_URL = "https://raw.githubusercontent.com/Ryuun0x/VoidHub/refs/heads/main/"

local ROUTES = {
    [126884695634066] = { name = "Garden World", file = "GardenWorld.lua" },
    [124977557560410] = { name = "Garden World", file = "GardenWorld.lua" },
    [129954712878723] = { name = "Trading World", file = "TradingWorld.lua" },
    [108890465381067] = { name = "Trading World", file = "TradingWorld.lua" },
    [97598239454123] = { name = "Garden World 2", file = "void.lua" },
    [77085202503540] = { name = "Garden World 2", file = "void.lua" },
    [107778070777162] = { name = "Steal An Egg", file = "CAE.lua" },
}

local route = ROUTES[game.PlaceId]
if not route then
    warn(string.format("[VoidHub] Unsupported game. PlaceId: %s", tostring(game.PlaceId)))
    return
end

local scriptUrl = BASE_URL .. route.file
local fetched, source = pcall(game.HttpGet, game, scriptUrl)
if not fetched then
    warn(string.format("[VoidHub] Failed to download %s: %s", route.name, tostring(source)))
    return
end

local chunk, compileError = loadstring(source)
if not chunk then
    warn(string.format("[VoidHub] Failed to compile %s: %s", route.name, tostring(compileError)))
    return
end

local ran, runtimeError = pcall(chunk)
if not ran then
    warn(string.format("[VoidHub] Failed to start %s: %s", route.name, tostring(runtimeError)))
end
