local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")
local Debris = game:GetService("Debris")

local Utilities = {
    Connections = {}
} Utilities.__index = nil; do
    Utilities.MoveTableIndexToBack = function(tbl, index)
        table.insert(tbl, table.remove(tbl, index))
    end

    Utilities.FindFirstDescendantOfClass = function(parent, class)
        for _, descendant in parent:GetDescendants() do
            if descendant.ClassName ~= class then 
                continue
            end

            return descendant
        end
    end

    Utilities.GetKeysFromTable = function(source_table, additional_item)
        local KeyList = {}

        for key in source_table do
            table.insert(KeyList, key)
        end

        if additional_item then
            table.insert(KeyList, additional_item)
        end

        return KeyList
    end

    Utilities.IsVisible = function(origin, destination)
        local RaycastParamaters = RaycastParams.new()

        RaycastParamaters.FilterType = Enum.RaycastFilterType.Blacklist
        RaycastParamaters.FilterDescendantsInstances = {
            Workspace.Terrain, 
            Workspace.Ignore, 
            Workspace.CurrentCamera, 
            Workspace:FindFirstChild("Players")
        }

        local RaycastResult = Workspace:Raycast(origin, destination - origin, RaycastParamaters)

        return RaycastResult == nil
    end

    Utilities.InterpolateColor = function(old, new, factor)
        factor = math.clamp(factor, 0, 1)

        return Color3.fromRGB(
            math.floor((1 - factor) * old.R * 255 + factor * new.R * 255),
            math.floor((1 - factor) * old.G * 255 + factor * new.G * 255),
            math.floor((1 - factor) * old.B * 255 + factor * new.B * 255)
        )
    end

    Utilities.AddConnection = function(connection_name, service, func)
        assert(connection_name, "AddConnection requires a valid connection name!")
        assert(service, "AddConnection requires a valid service!")
        assert(func, "AddConnection requires a valid function!")

        Utilities.Connections[connection_name] = service:Connect(func)
    end 

    Utilities.RemoveConnection = function(connection_name)
        assert(connection_name, "RemoveConnection requires a valid connection name!")

        local Connection = Utilities.Connections[connection_name]
        assert(Connection, "RemoveConnection couldn't find a connection for " .. connection_name .. "!")

        Connection:Disconnect()

        Utilities.Connections[connection_name] = nil
    end

    Utilities.ClearConnections = function()
        for _, connection in Utilities.Connections do
            if typeof(connection) == "RBXScriptConnection" then
                connection:Disconnect()
            end
        end

        table.clear(Utilities.Connections)
    end

    Utilities.CreateInstance = function(instance_name, parent, properties)
        local NewInstance = Instance.new(instance_name, parent)

        if properties then
            for property_name, value in properties do
                NewInstance[property_name] = value
            end
        end

        return NewInstance
    end

    Utilities.BeamsFolder = Utilities.CreateInstance("Part", Workspace.Ignore, {
        Name = "Beams"
    })

    Utilities.CreateBeam = function(origin, end_position, color, time, texture, texture_speed)
        local OriginAttachment = Utilities.CreateInstance("Attachment", Utilities.BeamsFolder, {
            Position = origin
        })

        local EndAttachment = Utilities.CreateInstance("Attachment", Utilities.BeamsFolder, {
            Position = end_position
        })

        local Beam = Utilities.CreateInstance("Beam", Utilities.BeamsFolder, {
            Color = ColorSequence.new(color),
            Attachment0 = OriginAttachment,
            TextureSpeed = texture_speed,
            Attachment1 = EndAttachment,
            LightInfluence = 100,
            Texture = texture,
            LightEmission = 0,
            FaceCamera = true,
            Enabled = true,
            Width0 = 2,
            Width1 = 2
        })

        Debris:AddItem(OriginAttachment, time)
        Debris:AddItem(EndAttachment, time)
        Debris:AddItem(Beam, time)
    end

    Utilities.JoinNewServer = function()
        local ServerList = HttpService:JSONDecode(
            game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
        )

        local JobId = ServerList.data[math.random(1, table.getn(ServerList.data))].id

        TeleportService:TeleportToPlaceInstance(game.PlaceId, JobId)
    end

    Utilities.Log = function(suffix, ...)
        warn("[" .. suffix .. "]", ...)
    end
end

return Utilities