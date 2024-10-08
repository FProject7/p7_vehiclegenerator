Config = {
    SearchWholeServer = true, -- this disables the whole ResourceName and SingleResource option and runs the script on the whole server.
    QbcoreTemplate = true, -- this enables the template to be same as qb-core, if disabled it works for qbox.
    UseSingleResource = false, -- if yes, then it will use the fivem native GetResourcePath.
    ResourceName = "vehiclemeta", -- resourcename / folder space
    EnableCommand = true, -- enables the command instead of the script automatically starting when the server starts.
    Command = "generatevehicles" -- the command
}

Extras = {
    GenerateVehicleShopTemplate = false, -- ['car-name'] = "pdm", for qbx_vehicleshop
    VehicleWhitelist = { -- vehicles you want to allow to be generated.
        "car-1",
        "car-2",
        "car-3",
    }, -- remove all entries and set VehicleWhitelistIsBlacklist to true, and all of them will generate
    VehicleWhitelistIsBlacklist = false, -- instead of whitelist it becomes blacklist
}