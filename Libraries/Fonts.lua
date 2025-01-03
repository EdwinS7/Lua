local HttpService = game:GetService("HttpService")

local Fonts = {
}; Fonts.__index = nil; do
    Fonts.NewFont = function(name, weight, style, asset)
        if not isfile(asset.FileName) then
            writefile(asset.FileName, asset.FontData)
        end

        if not isfile(name .. ".font") then
            writefile(name .. ".font", HttpService:JSONEncode({
                name = name,
    
                faces = {{
                    name = "Regular",
                    weight = weight,
                    style = style,
                    assetId = getcustomasset(asset.FileName),
                }}
            })) 
        end

        return getcustomasset(name .. ".font")
    end

    Fonts.Proggyclean = Fonts.NewFont("Proggyclean", 200, "normal", {
        FontData = game:HttpGet("https://raw.githubusercontent.com/EdwinS7/Lua/refs/heads/main/Proggyclean"),
        FileName = "Proggyclean.ttf"
    })
end

return Fonts