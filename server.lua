


local function get_directory()
    if Config.UseSingleResource and not Config.SearchWholeServer then
        return GetResourcePath(Config.ResourceName)
    else
        local mydir = GetResourcePath(GetCurrentResourceName())
        while mydir ~= "" and mydir:sub(-10) ~= "resources/" do
            mydir = mydir:sub(1, -2)
            mydir = mydir:match("^(.+[/\\])")
        end
        if not Config.SearchWholeServer then
            return mydir .. "/"
        else 
            return mydir .. Config.ResourceName .. "/"
        end
    end
end

local function read_file(filepath)
    local file = io.open(filepath, "r")
    if not file then
        print("Error: Cannot open file " .. filepath)
        return nil
    end
    local content = file:read("*all")
    file:close()
    return content
end

local function parse_vehicles_meta(content)
    local vehicles = {}
    local modelNamePattern = "<modelName>([^<]+)</modelName>"
    local vehicleMakeNamePattern = "<vehicleMakeName>([^<]+)</vehicleMakeName>"

    for modelName in content:gmatch(modelNamePattern) do
        local vehicle = {
            name = modelName,
            model = modelName,
            price = 0,
            hash = modelName,
            brand = content:match(vehicleMakeNamePattern) or "none",
            category = content:match(vehicleMakeNamePattern) or "none"
        }
        vehicles[#vehicles+1] = vehicle
    end
    return vehicles
end

local function find_and_process_vehicles_meta(directory)
    local files = {}
    for entry in io.popen('dir "' .. directory .. '" /b /s /a'):lines() do
        if entry:match("vehicles%.meta$") then
            files[#files+1] = entry
        end
    end

    local all_vehicles = {}
    for _, filepath in ipairs(files) do
        local content = read_file(filepath)
        if content then
            local vehicles = parse_vehicles_meta(content)
            for _, vehicle in ipairs(vehicles) do
                all_vehicles[#all_vehicles+1] = vehicle
            end
        end
    end

    return all_vehicles
end

function run()
    local output = ""
    for _, vehicle in ipairs(find_and_process_vehicles_meta(get_directory())) do
        if vehicle then
            if not Config.QbcoreTemplate then
                output = output .. string.format([[ ['%s'] = {
                name = '%s',
                brand = '%s',
                model = '%s',
                price = %d,
                category = '%s',
                hash = '%s'
            },]], vehicle.model, vehicle.name, vehicle.model, vehicle.model, vehicle.price, vehicle.category, vehicle.hash)
            else
                output = output .. string.format([[{
                model = '%s',
                name = '%s',
                brand = '%s',
                price = %d,
                category = '%s',
                type = 'automobile',
                shop = "none",
                },]], vehicle.model, vehicle.model, vehicle.brand, vehicle.price, vehicle.category)
            end
        else
            print('Found vehicle without data')
        end
    end

    local mydir = GetResourcePath(GetCurrentResourceName())
    while mydir ~= "" and mydir:sub(-10) ~= "resources/" do
        mydir = mydir:sub(1, -2)
        mydir = mydir:match("^(.+[/\\])")
    end
    mydir = mydir:sub(1, -2)
    mydir = mydir:match("^(.+[/\\])")

    local file = io.open(mydir .. "vehicles.lua", "w")
    if file then
        file:write(output)
        file:close()
        print("Output written to " .. mydir .. "output.lua")
    else
        print("Error: Cannot write to file " .. mydir .. "output.lua")
    end
end
if Config.EnableCommand then
    RegisterCommand(Config.Command, run, false)
else
    run()
end
