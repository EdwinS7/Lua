-- NOTE: Press Ctrl + K + 0 to minimize all code blocks
-- NOTE: Press Ctrl + K + 9 to expand all code blocks

--[[ Script Information
    Script Name: Phantom Forces Rage Client
    Author: @fuckuneedthisfor

    Date Created: October 17, 2024
    Last Updated: November 29, 2024
    Version: 1.5.0

    Description: 
        An expansive multi use cheat for legit cheating and
        extreme rage cheating / hvh.

    Dependencies:
        - Jan UI (slightly modified)

    Credits:
        - @ox_y / Office (Helped with some small stuff)
        - @.j.y. / J (Helped with some small stuff)
        - @serotuko / Sero (Replication stuff)
        - @finobe (Bullet tracer textures)

        - Lumora, Thorn, and Vaderhaxx for feature ideas
--]]

--[[ Comments Guide:
    TODO: Indicates tasks or features that need to be completed or addressed.
    NOTE: Provides general information or updates about the code.
    WARNING: Highlights potential or minor issues that need attention.
    FATAL: Indicates critical issues that require immediate action.
--]]

--[[ Coding Conventions:
    Variable Naming: Use PascalCase for variable names.
    Loop Variables: Use snake_case for loop-specific variables.
    Function Paramaters: Use snake_case for function-paramater variables.
]]

do -- NOTE: Check for other scripts.
    --[[if shared.Thorn then
        return warn("[PF Haxx] Thorn is already loaded!")
    end]]

    if shared.Lumora then
        return warn("[PF Haxx] Lumora is already loaded!")
    end

    if game:GetService("CoreGui"):FindFirstChild("Drawing API By iRay") then
        return warn("[PF Haxx] Wapus is already loaded!")
    end
end

-- Luarmor definitions
    if not LPH_OBFUSCATED then
        LPH_ENCSTR = function(...) return ... end
        LPH_ENCNUM = function(...) return ... end
        LPH_CRASH = function(...) return ... end
        LPH_JIT = function(...) return ... end
        LPH_JIT_MAX = function(...) return ... end
        LPH_NO_VIRTUALIZE = function(...) return ... end
        LPH_NO_UPVALUES = function(...) return ... end

        LRM_IsUserPremium = true
        LRM_LinkedDiscordID = "edwn"
    end
--

-- Globals
    local StartTime = os.clock()

    local PI = math.pi
    local Deg = 180 / PI
    local Rad = PI / 180

    -- WARNING: DISABLE THIS BEFORE RELEASE!
    local Developer = false
--

local Cheat = {
    Accent = Color3.fromRGB(160, 134, 255),
    Directory = "PF-Haxx",
    Name = "PF Haxx",
    Version = 1.0, -- TODO: Get this from Luarmor

    -- TODO: Update dis niggggggaaasz its not da new yearz no morz ya feelz mez cuhh
    Emoji = "\u{1F38A}", --[[🎊]]

    Username = "unknown",
    Build = "unknown",

    Services = {},

    Hooks = {
        Originals = {},
        Functions = {},
        Storage = {}
    },

    Modules = {},
    Libraries = {},

    Features = {},
} Cheat.__index = nil; do
    local Services = Cheat.Services
    local Hooks, Modules, Libraries = Cheat.Hooks, Cheat.Modules, Cheat.Libraries
    local Features = Cheat.Features

    local GetConfig = LPH_NO_VIRTUALIZE(function(flag, flag_option, list_value)
        local Option = Libraries.Interface.options[flag]

        if not Option then
            return
        end

        if not flag_option then
            if Option.type == "bind" then
                return Libraries.Interface.flags[flag]
            end

            return Option
        end

        if list_value then
            return Option[flag_option][list_value]
        end
        
        if Option.type == "color" then
            local Color = Option[flag_option]

            if typeof(Color) == "table" then
                return Color3.fromRGB(
                    Color.R * 255,
                    Color.G * 255,
                    Color.B * 255
                )
            end
        end

        return Option[flag_option]
    end)

    Services.ReplicatedStorage = game:GetService("ReplicatedStorage")
    Services.UserInputService = game:GetService("UserInputService")
    Services.TeleportService = game:GetService("TeleportService")
    Services.HttpService = game:GetService("HttpService")
    Services.RunService = game:GetService("RunService")
    Services.Workspace = game:GetService("Workspace")
    Services.Lighting =  game:GetService("Lighting")
    Services.CoreGui = game:GetService("CoreGui")
    Services.Players = game:GetService("Players")
    Services.Debris = game:GetService("Debris")

    local LocalPlayer = Services.Players.LocalPlayer
    local Camera = Services.Workspace.CurrentCamera

    if Developer then
        Cheat.Username = "admin"
        Cheat.Build = "developer"
    else
        Cheat.Username = LocalPlayer.Name

        -- TODO: Identify the user's build type by verifying the presence of a key (beta builds require a key)
        Cheat.Build = LRM_IsUserPremium and "beta" or "live"
    end

    do -- NOTE: Libraries
        local Require = function(library_name, url)
            local FoundFile, Library = pcall(function()
                return loadfile("PF-Haxx/Libraries/" .. library_name .. ".lua")
            end)

            return FoundFile and Library() or loadstring(game:HttpGet(url))()
        end

        local Repository = "https://raw.githubusercontent.com/EdwinS7/Lua/refs/heads/main/"

        Libraries = {
            Interface = Require("Jans UI", Repository .. "Libraries/Jans%20UI.lua"),
            Utilities = Require("Utilities", Repository .. "Libraries/Utilities.lua"),
            Math = Require("Math", Repository .. "Libraries/Math.lua"),
            Fonts = Require("Fonts", Repository .. "Libraries/Fonts.lua")
        }
    end

    do -- NOTE: Storage
        Cheat.Skyboxes = {
            ["Aesthetic Night"] = {
                SkyboxBk = "rbxassetid://1045964490",
                SkyboxDn = "rbxassetid://1045964368",
                SkyboxFt = "rbxassetid://1045964655",
                SkyboxLf = "rbxassetid://1045964655",
                SkyboxRt = "rbxassetid://1045964655",
                SkyboxUp = "rbxassetid://1045962969",
            },
            ["Elegant Morning"] = {
                SkyboxBk = "rbxassetid://153767241",
                SkyboxDn = "rbxassetid://153767216",
                SkyboxFt = "rbxassetid://153767266",
                SkyboxLf = "rbxassetid://153767200",
                SkyboxRt = "rbxassetid://153767231",
                SkyboxUp = "rbxassetid://153767288",
            },
            ["Fade Blue"] = {
                SkyboxBk = "rbxassetid://153695414",
                SkyboxDn = "rbxassetid://153695352",
                SkyboxFt = "rbxassetid://153695452",
                SkyboxLf = "rbxassetid://153695320",
                SkyboxRt = "rbxassetid://153695383",
                SkyboxUp = "rbxassetid://153695471",
            },
            ["Minecraft"] = {
                SkyboxBk = "rbxassetid://1876545003",
                SkyboxDn = "rbxassetid://1876544331",
                SkyboxFt = "rbxassetid://1876542941",
                SkyboxLf = "rbxassetid://1876543392",
                SkyboxRt = "rbxassetid://1876543764",
                SkyboxUp = "rbxassetid://1876544642",
            },
            ["Morning Glow"] = {
                SkyboxBk = "rbxassetid://1417494030",
                SkyboxDn = "rbxassetid://1417494146",
                SkyboxFt = "rbxassetid://1417494253",
                SkyboxLf = "rbxassetid://1417494402",
                SkyboxRt = "rbxassetid://1417494499",
                SkyboxUp = "rbxassetid://1417494643",
            },
            ["Night Sky"] = {
                SkyboxBk = "rbxassetid://12064107",
                SkyboxDn = "rbxassetid://12064152",
                SkyboxFt = "rbxassetid://12064121",
                SkyboxLf = "rbxassetid://12063984",
                SkyboxRt = "rbxassetid://12064115",
                SkyboxUp = "rbxassetid://12064131",
            },
            ["Pink Daylight"] = {
                SkyboxBk = "rbxassetid://271042516",
                SkyboxDn = "rbxassetid://271077243",
                SkyboxFt = "rbxassetid://271042556",
                SkyboxLf = "rbxassetid://271042310",
                SkyboxRt = "rbxassetid://271042467",
                SkyboxUp = "rbxassetid://271077958",
            },
            ["Purple And Blue"] = {
                SkyboxLf = "rbxassetid://149397684",
                SkyboxBk = "rbxassetid://149397692",
                SkyboxDn = "rbxassetid://149397686",
                SkyboxFt = "rbxassetid://149397697",
                SkyboxRt = "rbxassetid://149397688",
                SkyboxUp = "rbxassetid://149397702",
            },
            ["Purple Clouds"] = {
                SkyboxLf = "rbxassetid://151165191",
                SkyboxBk = "rbxassetid://151165214",
                SkyboxDn = "rbxassetid://151165197",
                SkyboxFt = "rbxassetid://151165224",
                SkyboxRt = "rbxassetid://151165206",
                SkyboxUp = "rbxassetid://151165227",
            },
            ["Purple Nebula"] = {
                SkyboxLf = "rbxassetid://159454286",
                SkyboxBk = "rbxassetid://159454299",
                SkyboxDn = "rbxassetid://159454296",
                SkyboxFt = "rbxassetid://159454293",
                SkyboxRt = "rbxassetid://159454300",
                SkyboxUp = "rbxassetid://159454288",
            },
            ["Setting Sun"] = {
                SkyboxBk = "rbxassetid://626460377",
                SkyboxDn = "rbxassetid://626460216",
                SkyboxFt = "rbxassetid://626460513",
                SkyboxLf = "rbxassetid://626473032",
                SkyboxRt = "rbxassetid://626458639",
                SkyboxUp = "rbxassetid://626460625",
            },
            Cache = {
                SkyboxBk = "rbxassetid://220513302",
                SkyboxDn = "rbxassetid://213221473",
                SkyboxFt = "rbxassetid://220513328",
                SkyboxLf = "rbxassetid://220513318",
                SkyboxRt = "rbxassetid://220513279",
                SkyboxUp = "rbxassetid://220513345",
            },
            Neptune = {
                SkyboxBk = "rbxassetid://218955819",
                SkyboxDn = "rbxassetid://218953419",
                SkyboxFt = "rbxassetid://218954524",
                SkyboxLf = "rbxassetid://218958493",
                SkyboxRt = "rbxassetid://218957134",
                SkyboxUp = "rbxassetid://218950090",
            },
            Redshift = {
                SkyboxBk = "rbxassetid://401664839",
                SkyboxDn = "rbxassetid://401664862",
                SkyboxFt = "rbxassetid://401664960",
                SkyboxLf = "rbxassetid://401664881",
                SkyboxRt = "rbxassetid://401664901",
                SkyboxUp = "rbxassetid://401664936",
            },
            Twilight = {
                SkyboxLf = "rbxassetid://264909758",
                SkyboxBk = "rbxassetid://264908339",
                SkyboxDn = "rbxassetid://264907909",
                SkyboxFt = "rbxassetid://264909420",
                SkyboxRt = "rbxassetid://264908886",
                SkyboxUp = "rbxassetid://264907379",
            }
        }

        Cheat.Materials = {
            ForceField = Enum.Material.ForceField,
            Glass = Enum.Material.Glass,
            Neon = Enum.Material.Neon,
            Plastic = Enum.Material.Plastic,
            Foil = Enum.Material.Foil,
            Ice = Enum.Material.Ice,
            Snow = Enum.Material.Snow,
            Cobblestone = Enum.Material.Cobblestone,
            Marble = Enum.Material.Marble
        }

        Cheat.Textures = {
            Web = "rbxassetid://301464986",
            Webbed = "rbxassetid://2179243880",
            Scanning = "rbxassetid://5843010904",
            Pixelated = "rbxassetid://140652787",
            Swirl = "rbxassetid://8133639623",
            Checkerboard = "rbxassetid://5790215150",
            Christmas = "rbxassetid://6853532738",
            Player = "rbxassetid://4494641460",
            Shield = "rbxassetid://361073795",
            Dots = "rbxassetid://5830615971",
            Bubbles = "rbxassetid://1461576423",
            Matrix = "rbxassetid://10713189068",
            Honeycomb = "rbxassetid://179898251",
            Groove = "rbxassetid://10785404176",
            Cloud = "rbxassetid://5176277457",
            Sky = "rbxassetid://1494603972",
            Smudge = "rbxassetid://6096634060",
            Scrapes = "rbxassetid://6248583558",
            Galaxy = "rbxassetid://1120738433",
            Galaxies = "rbxassetid://5101923607",
            Stars = "rbxassetid://598201818",
            Rainbow = "rbxassetid://10037165803",
            Wires = "rbxassetid://14127933",
            Camo = "rbxassetid://3280937154",
            Hexagon = "rbxassetid://6175083785",
            Particles = "rbxassetid://1133822388",
            Triangular = "rbxassetid://4504368932",
            Wall = "rbxassetid://4271279",
            Poland = "rbxassetid://140652787"
        }

        Cheat.Hitsounds = {
            Minecraft = "rbxassetid://4018616850",
            Metallic = "rbxassetid://5633695679", -- NOTE: From Gamesense / Skeet
            Legacy = "rbxassetid://3124331820", -- NOTE: From Bameware
            Flick = "rbxassetid://6607204501", -- NOTE: From Neverlose
            Token = "rbxassetid://6534947869", -- NOTE: From Fatality
            Bell = "rbxassetid://6534947240",    
            Bonk = "rbxassetid://5766898159", -- NOTE: From Luney Toons
            Rust = "rbxassetid://1255040462",
            Osu = "rbxassetid://7149255551",
            Pop = "rbxassetid://198598793"
        }

        Cheat.Tracers = {
            Default = "rbxassetid://446111271",
            Beam = "rbxassetid://7151777149",
            ["Bitch bot"] = "rbxassetid://446111271",

            -- NOTE: Thanks @finobe
            ["Double Helix"] = "rbxassetid://1134824633", 
            Electric = "rbxassetid://446111271",
            ["Electric + Glow"] = "rbxassetid://5864341017", 
            Fade = "rbxassetid://7136858729",
            Pulsate = "rbxassetid://5889875399", 
            ["Red Lazer"] = "rbxassetid://6333823534", 
            Smoke = "rbxassetid://3517446796", 
            Warp = "rbxassetid://7151778302",

            -- NOTE: Thanks @rahrah00 / rash rash
            Lake = "rbxassetid://7151778302",
            Flow = "rbxassetid://446111271",
            Chain = "rbxassetid://4483345998"
        }

        -- NOTE: Written by the best coder ever, ME!
        -- NOTE: No im joking it was Claude and ChatGPT, I'd never write this corny ass shit.
        Cheat.ChatMessages = {
            Nerdy = {
                "The probability of your survival was approximately 0%!",
                "According to my calculations, you lost!",
                "Have you tried turning yourself off and on again?",
                "I find your lack of skills disturbing...",
                "Did you know the average player lasts longer than that?",
                "Executing victory protocol...",
                "Your strategy had several logical fallacies",
                "I'm afraid I can't let you win, Dave",
                "My algorithms predicted this outcome",
                "Would you like to restore from your last save point?",
                "Error 404: Your skills not found",
                "Time to recalibrate your gaming parameters!",
                "That was a statistically significant defeat",
                "Your performance was suboptimal",
                "Initiating victory dance subroutine",
                "You've been debugged!",
                "That's what happens when you bring a sword to a science fight",
                "Have you considered updating your tactics?",
                "Your defeat was theoretically inevitable",
                "Processing... yep, you lost!"
            },

            Wizard = {
                "Your magic is no match for mine!",
                "Back to wizard school with you!",
                "By the power of the arcane!",
                "Your spells need more practice",
                "Alakazam! You lose!",
                "The stars foretold your defeat",
                "Your mana has run dry",
                "Feel the power of true magic!",
                "Should have studied your spellbooks",
                "The elements themselves reject you!",
                "Enchantment overruled, goodbye!",
                "You’re not in the same league of wizards!",
                "This is why I’m the Archmage!",
                "A spell a day keeps fools at bay!",
                "Bewitched, bothered, and bewildered? Too bad!",
                "Your wand work needs work!",
                "Outsmarted and out-magic’d!",
                "I saw your defeat in my crystal ball!",
                "Abracadabra—you're done!",
                "The arcane arts do not favor you!",
                "Banished to the shadow realm you go!",
                "Your incantations lack inspiration!",
                "Magical misfire—better luck next time!",
                "Even a novice would cast better spells!",
                "You’re no match for my ancient wisdom!",
                "The runes foretold your downfall!",
                "Begone, unworthy sorcerer!",
                "My magic, your demise!",
                "Mystic might always prevails!",
                "The ether answers only to me!",
                "Another failed apprentice defeated!",
                "Your charms have no charm against me!",
                "A flick of my wand, and it’s over!",
                "The cosmos laughs at your efforts!",
                "Even the ley lines abandon you!",
                "One with the void, your magic is no more!"
            },

            Sassy = {
                "Did you forget which buttons to press?",
                "Maybe try the tutorial next time?",
                "Was that your little brother playing?",
                "Nice attempt! (Not really)",
                "You're making this too easy!",
                "Are you playing with your eyes closed?",
                "Yawn... next please!",
                "Is that the best you've got?",
                "Were you even trying?",
                "Back to practice mode for you!",
                "Thanks for the free win!",
                "Pressing random buttons isn't a strategy",
                "My grandma plays better than that",
                "Did you disconnect or something?",
                "Might want to stick to single player",
                "Playing on a calculator?",
                "Nice gaming chair! (Get a better one)",
                "Controller batteries must be low",
                "First day playing?",
                "Uninstall = best strategy"
            },

            Zesty = {
                "Gotcha, sugar! 🌈",
                "Slayed, darling! 💅",
                "Rainbow warrior strikes again! 🌈",
                "Taste the rainbow, sweetie! 🌈",
                "Serving justice and fabulousness! 💖",
                "Out and proud of this kill! 🏳️‍🌈",
                "Kissed the ground in style! 😘",
                "Another fabulous win! 💃",
                "No tea, no shade, just slay! ☕",
                "Love wins, and you lost! ❤️",
                "Yas queen, that's a wrap! 👑",
                "Fierce and flawless, honey! 💎",
                "Strike a pose, now you're toast! 📸",
                "Drama-free, just excellence! ✨",
                "Oop—snatched that victory! 🖐️",
                "They couldn't handle this sparkle! 🌟",
                "Another one bites the glitter! ✨",
                "Unapologetically iconic, darling! 💋",
                "Bye-bye, darling! Toodle-loo! 👋",
                "This slay is brought to you by fabulousness! 💼",
                "Crowned and lethal, honey! 👑✨",
                "Serving defeat on a silver platter! 🍽️",
                "Eleganza extravaganza, and you're out! 💃",
                "Haters gonna hate, slayers gonna slay! 😎",
                "Straight-up fabulous destruction! 💥",
                "Nothing personal, just fabulous! ✨",
                "Spreading rainbows and wreckage! 🌈💥",
                "Too glam to give a damn! 💄",
                "Caught in the crossfire of excellence! 🔥",
                "One shot, one slay! 🎯",
                "Sprinkling glitter and devastation! ✨💥",
                "Bold, beautiful, and victorious! 💅",
                "They fell for the sparkle trap! 💎",
                "Death by fabulousness, darling! 💋",
                "The spotlight's on me, not you! 🌟",
                "A graceful exit—for you! 🎭",
                "Flawlessly unstoppable! 🚀",
                "Consider yourself served, darling! 🍹",
                "Sashay away—permanently! 💃❌"
            },

            ["Bitch Bot"] = {
                "It literally wipes every lobby",
                "It LITERALLY wipes every lobby",
                "It LITERALLY wipes every lobby, literally.",
                "I love binging acid everyday",
                "Mmmmm 25I-NBombe, tastes amazing",
                "Im an addict in a world of addictions",
                "Im literally mentally retarded guys stop bullying me",
                "my name is alan and I like to snort "
            }
        }
    end

    do -- NOTE: Modules
        local Require

        for _, func in getgc(false) do
            if type(func) == "function" and islclosure(func) and debug.getinfo(func).name == "require" and string.find(debug.getinfo(func).source, "ClientLoader") then
                Require = func

                break
            end
        end

        if not Require then
            -- WARNING: This is detectable.
            Require = assert(assert(getrenv().shared, "FAILED TO GET THE SHARED TABLE!").require, "FAILED TO GET THE REQUIRE FUNCTION!")
        end

        local Cache, ModuleCount = debug.getupvalue(Require, 1)._cache, 0

        for module_name, module in Cache do
            Modules[module_name] = module.module
            ModuleCount += 1
        end
    end

    -- WARNING: Ensure that the game is ready.
    repeat task.wait() until Modules.NetworkClient:isReady()
    
    local Reversed; do
        Reversed = {
            
        } Reversed.__index = nil; do
            Reversed.GetFirearmObject = function()
                local WeaponController = Modules.WeaponControllerInterface:getActiveWeaponController()
    
                if not WeaponController then
                    return
                end
    
                return WeaponController._activeWeaponRegistry[WeaponController._activeWeaponIndex], WeaponController
            end
    
            Reversed.CanFire = function(firearm_object, force_reload)
                if not firearm_object._magCount then
                    return
                end

                if force_reload and firearm_object._magCount <= 0 then
                    Reversed.Reload(firearm_object)
                end
    
                if firearm_object._magCount <= 0 then
                    return false
                end
    
                if Modules.GameClock.getTime() < firearm_object._nextShot then
                    return false
                end
    
                return true
            end
    
            Reversed.Reload = function(weapon)
                local MagSize = weapon:getWeaponStat("magsize") + (weapon:getWeaponStat("chamber") and 1 or 0) - weapon._magCount
    
                if MagSize < weapon._spareCount then
                    weapon._magCount = weapon._magCount + MagSize
                    weapon._spareCount = weapon._spareCount - MagSize
                else
                    weapon._magCount = weapon._magCount + weapon._spareCount
                    weapon._spareCount = 0
                end
    
                if MagSize > 0 then
                    Modules.NetworkClient:send("reload")
                end
            end
            
            Reversed.OnPlayerHitRebuilt = function(v50, v51, v52, hitbox_name, v54, v55)
                local PlayerHits = v50.extra.playersHit
    
                if PlayerHits[v51] then
                    return
                end
    
                PlayerHits[v51] = true
                
                -- NOTE: Setting the last paramater makes it skip the game calling 'bullethit'
                -- NOTE: Since were sending it ourselves later on within the ragebot it's not needed here.
                Modules.HitDetectionInterface.playerHitDection(v50, v51, v52, hitbox_name, v54, true)
            end
    
            Reversed.HitDetectionRebuilt = function(v22, v23, v24, v25, v26, v27)
                if not (v23 and v23.Anchored) then
                    return
                end
    
                if v23.Name == "Window" then
                    Modules.Effects.breakwindow(v23, v22.extra.bulletTicket);
                elseif v23.Name == "Hitmark" then
                    -- NOTE: Force head, we only shoot at head.
                    Modules.HudCrosshairsInterface.fireHitmarker(true)
                elseif v23.Name == "HitmarkHead" then
                    Modules.HudCrosshairsInterface.fireHitmarker(true)
                end
    
                Modules.Effects.bullethit(v23, v24, v25, v26, v27, v22.velocity, true, true, math.random(0, 2))
            end
            
            do -- NOTE: Polynomials
                --[[ NOTE: The native-Lua Cardano-Ferrari quartic formula
                    solveQuartic(number a, number b, number c, number d, number e)
                    returns number s0, number s1, number s2, number s3

                    Will return nil for roots that do not exist.

                    Solves for the roots of quartic polynomials of the form:
                    ax^4 + bx^3 + cx^2 + dx + e = 0
                --]]

                local EPS = 1e-9

                Reversed.SolveQuartic = LPH_JIT_MAX(function(a, b, c, d, e)
                    if not a then
                        return
                    end
                
                    if a > EPS and a < EPS then
                        return Reversed.SolveQuartic(b, c, d, e)
                    end
                
                    if e then -- NOTE: Quartic equation (4th degree)
                        local Shift = -b / (4 * a)
                
                        local P = (c + Shift * (3 * b + 6 * a * Shift)) / a
                        local Q = (d + Shift * (2 * c + Shift * (3 * b + 4 * a * Shift))) / a
                        local R = (e + Shift * (d + Shift * (c + Shift * (b + a * Shift)))) / a
                
                        -- NOTE: pretty much just Q ≈ 0
                        if math.abs(Q) < EPS then
                            local R1, R2 = Reversed.SolveQuartic(1, P, R)
                
                            if R2 and R2 >= 0 then
                                local Sqrt1, Sqrt2 = math.sqrt(R1), math.sqrt(R2)
                
                                return Shift - Sqrt2, Shift - Sqrt1, Shift + Sqrt1, Shift + Sqrt2
                            end
                
                            return
                        end
                
                        local Cubic = Reversed.SolveQuartic(1, 2 * P, P * P - 4 * R, -Q * Q)
                
                        if not Cubic then 
                            return
                        end
                
                        local CubicSqrt = math.sqrt(Cubic)
                        local CubicTerm = (Cubic + P) / 2
                
                        local Q1, Q2 = Reversed.SolveQuartic(1, CubicSqrt, CubicTerm - Q / (2 * CubicSqrt))
                        local Q3, Q4 = Reversed.SolveQuartic(1, -CubicSqrt, CubicTerm + Q / (2 * CubicSqrt))
                
                        if Q1 and Q3 then
                            return Shift + Q4, Shift + Q3, Shift + Q2, Shift + Q1
                        elseif Q1 then
                            return Shift + Q2, Shift + Q1
                        elseif Q3 then
                            return Shift + Q4, Shift + Q3
                        end
                    elseif d then -- NOTE: Cubic (3rd degree)
                        local Shift = -b / (3 * a)
                
                        local P = -(c + Shift * (2 * b + 3 * a * Shift)) / (3 * a)
                        local Q = -(d + Shift * (c + Shift * (b + a * Shift))) / (2 * a)
                
                        local Disc = Q * Q - P * P * P
                        local SqrtAbsDisc = math.sqrt(math.abs(Disc))
                
                        if Disc > 0 then
                            local U = Q + SqrtAbsDisc
                            local V = Q - SqrtAbsDisc
                
                            local Cbrt1 = U < 0 and -(-U)^(1/3) or U^(1/3)
                            local Cbrt2 = V < 0 and -(-V)^(1/3) or V^(1/3)
                
                            return Shift + Cbrt1 + Cbrt2
                        end
                
                        local Theta = math.atan2(SqrtAbsDisc, Q) / 3
                        local R = 2 * math.sqrt(P)
                
                        return Shift - R * math.sin(Theta + PI / 6),
                            Shift + R * math.sin(Theta - PI / 6),
                            Shift + R * math.cos(Theta)
                    elseif c then -- NOTE: Quadratic (2nd degree)
                        local Shift = -b / (2 * a)
                        local Disc = Shift * Shift - c / a
                
                        if Disc >= 0 then
                            local SqrtDisc = math.sqrt(Disc)

                            return Shift - SqrtDisc, Shift + SqrtDisc
                        end

                        return
                    elseif b then -- NOTE: Linear (1st degree)
                        return -b / a
                    end
                end)
            end
    
            Reversed.Trajectory = LPH_JIT_MAX(function(origin, target, acceleration, velocity, offset)
                local Direction = target - origin
    
                local VelocitySquared = Vector3.zero.Dot(Vector3.zero, Vector3.zero)
                local DirectionSquared = Vector3.zero.Dot(Direction, Direction)
    
                local Time1, Time2, Time3, Time4 = Reversed.SolveQuartic(
                    Vector3.zero.Dot(acceleration, acceleration) * 0.25,
                    VelocitySquared,
                    DirectionSquared + VelocitySquared - velocity ^ 2,
                    VelocitySquared * 2, 
                    DirectionSquared
                )
                
                local Time = (Time1 > 0 and Time1) or (Time2 > 0 and Time2) or (Time3 > 0 and Time3) or Time4
                local Trajectory = (Direction + (offset or Vector3.zero) * Time + 0.5 * acceleration * Time ^ 2) / Time
                
                return Trajectory, Time
            end)
    
            Reversed.IsDirtyFloat = function(float)
                if float ~= float then
                    return true
                end
                
                return float == 1e999 or float == -1e999
            end
    
            Reversed.RaycastFilter = function(instance)
                return not instance.CanCollide or instance.Transparency == 1
            end

            -- NOTE: Wrong!!
            Reversed.TimeHit = LPH_JIT_MAX(function(origin, target, acceleration, velocity)
                local Direction = origin - target
                
                local Time1, Time2, Time3, Time4 = Reversed.SolveQuartic(
                    acceleration:Dot(acceleration) / 3,
                    acceleration:Dot(velocity) * 2,
                    velocity:Dot(velocity) + acceleration:Dot(Direction) * 2,
                    Direction:Dot(velocity) * 2
                )
                
                local BestTime, ShortestDistance = math.huge, 0
                
                for _, Time in {Time1, Time2, Time3, Time4} do
                    local Position = (Direction + Time * velocity + 0.5 * acceleration * Time * Time).Magnitude
                    
                    if Time > 0 and Position < BestTime then
                        ShortestDistance = Position
                        BestTime = Time
                    end
                end
                
                return BestTime, ShortestDistance
            end)
    
            Reversed.BulletCheck = LPH_JIT_MAX(function(start_pos, target_pos, trajectory, acceleration, penetration_depth, maximum_penetrations, time_step)
                local TimeToHit = Modules.PhysicsLib.timehit(start_pos, trajectory, acceleration, target_pos)
                
                if Reversed.IsDirtyFloat(TimeToHit) or TimeToHit > Modules.PublicSettings.bulletLifeTime then
                    return false
                end
            
                -- NOTE: 1 / 60
                time_step = time_step or 0.016667
            
                local ElapsedTime = 0
                local HitTarget = true
                local HasPenetrated = false
    
                local PenetrationCount = 0
            
                local ProjectilePosition = start_pos
                local ProjectileVelocity = trajectory
                local RemainingPenetration = penetration_depth
    
                local ObjectsToIgnore = {
                    workspace.Terrain, 
                    workspace.Ignore, 
                    workspace.CurrentCamera, 
                    workspace:FindFirstChild("Players")
                }
            
                while ElapsedTime < TimeToHit and PenetrationCount < maximum_penetrations do
                    local DeltaTime = math.min(time_step, TimeToHit - ElapsedTime)
                    local StepDisplacement = DeltaTime * ProjectileVelocity + 0.5 * acceleration * DeltaTime * DeltaTime
            
                    local RaycastResult = Modules.Raycast.raycast(ProjectilePosition, StepDisplacement, ObjectsToIgnore, function(instance)
                        return not instance.CanCollide or instance.Transparency == 1
                    end, true)
                    
                    if RaycastResult then
                        local HitInstance = RaycastResult.Instance
                        local HitPosition = RaycastResult.Position
                        local HitNormal = StepDisplacement.unit
            
                        local ExitResult = Modules.Raycast.raycastSingleExit(HitPosition, HitInstance.Size.magnitude * HitNormal, HitInstance)
    
                        if ExitResult then
                            RemainingPenetration = RemainingPenetration - HitNormal:Dot(ExitResult.Position - HitPosition)
    
                            if RemainingPenetration < 0 then
                                return false, HasPenetrated, RemainingPenetration
                            end
    
                            PenetrationCount = PenetrationCount + 1
                            HasPenetrated = true
                        end
                        
                        local ImpactDeltaTime = (HitPosition - ProjectilePosition):Dot(StepDisplacement) / StepDisplacement:Dot(StepDisplacement) * DeltaTime
                        ProjectilePosition = HitPosition + 0.01 * (ProjectilePosition - HitPosition).unit
                        ProjectileVelocity = ProjectileVelocity + ImpactDeltaTime * acceleration
                        ElapsedTime = ElapsedTime + ImpactDeltaTime
            
                        table.insert(ObjectsToIgnore, HitInstance)
                    else
                        ProjectilePosition = ProjectilePosition + StepDisplacement
                        ProjectileVelocity = ProjectileVelocity + DeltaTime * acceleration
                        ElapsedTime = ElapsedTime + DeltaTime
                    end
                end

                return PenetrationCount < maximum_penetrations, HasPenetrated, RemainingPenetration
            end)
    
            -- NOTE: Not really a 'reversed' function, just simplifies the process of bullet path validation.
            Reversed.IsPenetrable = LPH_JIT_MAX(function(origin, destination, penetration_depth, bullet_speed, maximum_penetrations)
                local BulletAcceleration = Modules.PublicSettings.bulletAcceleration
    
                local Trajectory, TimeHit = Reversed.Trajectory(
                    origin, destination, -BulletAcceleration,
                    bullet_speed, Vector3.zero
                )
    
                local HitTarget = Reversed.BulletCheck(
                    origin, destination, Trajectory,
                    BulletAcceleration, penetration_depth,
                    maximum_penetrations
                )
                
                return HitTarget, Trajectory, TimeHit
            end)

            -- NOTE: Not really a 'reversed' function, just simplifies the process of checking if the round is paused.
            Reversed.IsRoundPaused = function()
                if not (Modules.RoundSystemClientInterface.isRunning() and not Modules.RoundSystemClientInterface.isCountingDown()) then
                    return true
                end

                if Modules.RoundSystemClientInterface.roundLock then
                    return true
                end

                return false
            end
        end
    end

    local PlayerInformation; do
        PlayerInformation = {
            Players = {},

            LocalPlayer = {
                Position = Vector3.zero,
                ViewAngles = Vector3.zero,

                Alive = true
            }
        }; do
            PlayerInformation.AddPlayer = function(entry, position, viewangles)
                assert(entry, "Failed to obtain player thirdperson_object from replication update?")
                assert(entry, "Failed to obtain player character from replication update?")
                assert(entry, "Failed to obtain player entry from replication update?")

                assert(entry, "Failed to obtain player position from replication update?")
                assert(entry, "Failed to obtain player angles from replication update?")

                local TargetPositions = {}

                if GetConfig("Ragebot Target Scanning", "state") then
                    TargetPositions = Features.Ragebot.GenerateSpherePositions(
                        TargetPositions, position, GetConfig("Ragebot Performance Mode", "state"), 
                        GetConfig("Ragebot Target Scanning Distance", "value"),
                        GetConfig("Ragebot Target Scanning Randomization", "state")
                    )
                end

                local ThirdPersonObject = entry:getThirdPersonObject()

                PlayerInformation.Players[entry._player.Name] = {
                    ThirdPersonObject = ThirdPersonObject,
                    CharacterHash = ThirdPersonObject._characterModelHash,
                    Character = ThirdPersonObject._characterModel,
                    TargetPositions = TargetPositions,
                    Player = entry._player,
                    Entry = entry,
                    Alive = true,

                    ViewAngles = viewangles,
                    Position = position
                }
            end

            PlayerInformation.RemovePlayer = function(player_name)
                PlayerInformation.Players[player_name] = nil
            end

            PlayerInformation.GetPlayerByName = function(player_name)
                return PlayerInformation.Players[player_name]
            end
        end
    end

    do -- NOTE: Features
        do --  NOTE: Legitbot
            Features.Legitbot = {
                -- TODO: This won't happen for a while probably (2-3 weeks at least - 12/23/2024)
            }; do
                Features.Legitbot.AddTarget = function(player)
                    
                end
    
                Features.Legitbot.RemoveTarget = function(player)
    
                end
    
                Features.Legitbot.Step = function()
                    
                end
            end
        end
  
        do --  NOTE: Ragebot
            Features.Ragebot = {
                ProcessedTargetIndex = 1,
                CachedTargets = nil,
                ActiveTarget = nil,

                -- Fire position / Target position Scanning
                UnitSpherePoints = {},
                FirePositions = {}
            }; do
                -- TODO: Add Teleport scanning (we could use pathfinding for this but nah, too slow probably).
                -- TODO: Add knifebot pathfinding (we need to make a path finding library first).

                do -- Pre-compute sphere points
                    local GenerateUnitSpherePoints = function(point_count)
                        local Points = {}
    
                        for i = 1, point_count do
                            local Theta = math.random() * 2 * PI
                            local Phi = math.acos(2 * math.random() - 1)
                            
                            Points[i] = {
                                math.sin(Phi) * math.cos(Theta),
                                math.sin(Phi) * math.sin(Theta),
                                math.cos(Phi)
                            }
                        end
    
                        return Points
                    end

                    -- Were doing (points ^ 2) scans (per player)
                    -- NOTE: 10^(2 aka origin_points * target_points) = 36 points (Normal)
                    -- NOTE: 5^(2 aka origin_points * target_points) = 16 Points (Performance)

                    Features.Ragebot.UnitSpherePoints.Normal = GenerateUnitSpherePoints(6)
                    Features.Ragebot.UnitSpherePoints.Performance = GenerateUnitSpherePoints(4)
                end
            
                Features.Ragebot.GenerateSpherePositions = function(positions, replication_position, performance_mode, radius, randomization)
                    local SpherePoints = performance_mode and Features.Ragebot.UnitSpherePoints.Performance or Features.Ragebot.UnitSpherePoints.Normal

                    for _, point in SpherePoints do
                        local ActualRadius = randomization and math.sqrt(math.random(0, radius ^ 2)) or radius

                        local Position = Vector3.new(
                            replication_position.X + ActualRadius * point[1],
                            replication_position.Y + ActualRadius * point[2],
                            replication_position.Z + ActualRadius * point[3]
                        )
                        
                        positions[#positions + 1] = Position
                    end

                    return positions
                end

                Features.Ragebot.FilterTargets = function(targets, origin_position, origin_angles, field_of_view, limit_distance, maximum_distance)
                    local FilteredTargets = {}

                    for _, target in targets do
                        if target.Player.Team == LocalPlayer.Team then
                            continue
                        end

                        local Angle = Deg * Libraries.Math.AngleBetweenVector3(
                            CFrame.new(origin_position, origin_position + origin_angles),
                            CFrame.new(origin_position, target.Position).LookVector.Unit
                        )

                        if Angle > field_of_view then
                            continue
                        end

                        if limit_distance  then
                            local Distance = (target.Position - origin_position).Magnitude

                            if Distance > maximum_distance then
                                continue
                            end
                        end

                        FilteredTargets[#FilteredTargets + 1] = target
                    end

                    return FilteredTargets
                end

                Features.Ragebot.SortTargets = function(filtered_targets, origin, sorting_mode)
                    table.sort(filtered_targets, function(player, other_player)
                        if sorting_mode == "Health" then
                            return player.Entry:getHealth() < other_player.Entry:getHealth()
                        elseif sorting_mode == "Distance" then
                            local PlayerDistance = (player.Position - origin).Magnitude
                            local OtherPlayerDistance = (other_player.Position - origin).Magnitude

                            return PlayerDistance < OtherPlayerDistance
                        end
                    end)

                    return filtered_targets
                end

                Features.Ragebot.IsPenetrable = LPH_JIT_MAX(function(origins, destinations, prediction, penetration_depth, bullet_speed, maximum_penetrations, bulletcheck_timestep)
                    local BulletAcceleration = Modules.PublicSettings.bulletAcceleration
        
                    for _, origin in origins do
                        for destination_index, destination in destinations do
                            local Trajectory, TimeHit = Reversed.Trajectory(
                                origin, destination, -BulletAcceleration,
                                bullet_speed, prediction or Vector3.zero
                            )
            
                            local HitTarget = Reversed.BulletCheck(
                                origin, destination, Trajectory,
                                BulletAcceleration, penetration_depth,
                                maximum_penetrations, bulletcheck_timestep
                            )
                            
                            -- NOTE: Failed to hit so move this point to the back of our destionations list to scan it last next time.
                            if not HitTarget then
                                Libraries.Utilities.MoveTableIndexToBack(destinations, destination_index)
                                continue
                            end

                            return origin, destination, HitTarget, Trajectory, TimeHit
                        end
                    end
                end)
                
                Features.Ragebot.BulletHit = function(sorted_targets, target, weapon, bullets, destination)
                    for _, bullet in bullets do
                        Modules.NetworkClient:send("bullethit", weapon.uniqueId,
                            target.Player, destination, "Head",
                            bullet[2], Modules.GameClock.getTime()
                        )
                    end

                    -- NOTE: Attempt to collat
                    for _, other_target in sorted_targets do
                        if target == other_target then
                            continue
                        end

                        local CanHit = false

                        -- NOTE: I'm assuming 10 is the maximum, worth testing tho.
                        if (other_target.Position - target.Position).Magnitude <= 10 then
                            CanHit = true
                            break
                        end

                        if not CanHit then
                            continue
                        end

                        for _, bullet in bullets do
                            Modules.NetworkClient:send("bullethit", weapon.uniqueId,
                                other_target.Player, destination, "Head",
                                bullet[2], Modules.GameClock.getTime()
                            )
                        end
                    end
                end

                Features.Ragebot.BestFirerate = function(weapon)
                    local BestFirerate = Modules.GameClock.getTime()

                    if weapon:getWeaponStat("firecap") then
                        BestFirerate = BestFirerate + 60 / weapon:getWeaponStat("firecap")
                    elseif weapon:getWeaponStat("autoburst") and weapon._auto then
                        BestFirerate = BestFirerate + 60 / weapon:getWeaponStat("burstfirerate")
                    else -- NOTE: We shouldn't even hit this, just a fail safe.
                        BestFirerate = BestFirerate + 60 / weapon:getFirerate()
                    end

                    BestFirerate = BestFirerate + (LocalPlayer:GetNetworkPing() / 1000)

                    return BestFirerate
                end

                Features.Ragebot.Shoot = function(sorted_targets, weapon, target, trajectory, time_hit, origin, destination)
                    local Bullets, FireCount = {}, weapon._fireCount

                    local Velocity = (weapon:getWeaponStat("bulletspeed") or 0) * trajectory
                    local Acceleration = (weapon:getWeaponStat("bulletaccell") or 0) * trajectory + Modules.PublicSettings.bulletAcceleration

                    local TimeDiff = Modules.GameClock.getTime() - weapon._nextShot

                    local UsingGlassHack = Modules.PlayerSettingsInterface.getValue("toggleglasshacktracers")
                        and weapon:isAiming() and not weapon:isBlackScoped() and weapon:getActiveAimStat("sightObject"):isApertureVisible()

                    for i = 1, weapon:getWeaponStat("pelletcount") or 1 do
                        FireCount += 1
    
                        Modules.BulletInterface.newBullet({
                            position = origin, size = 0.2,
                            visualorigin = weapon._barrelPart.Position,
    
                            color = weapon:getWeaponStat("bulletcolor") or Color3.fromRGB(230, 120, 255),
                            brightness = weapon:getWeaponStat("bulletbrightness") or 400, bloom = 0.005,
    
                            life = Modules.PublicSettings.bulletLifeTime,
    
                            velocity = Velocity,
                            acceleration = Acceleration,
                            penetrationdepth = weapon:getWeaponStat("penetrationdepth"),
                            dt = TimeDiff,
    
                            tracerless = weapon:getWeaponStat("tracerless"),
                            usingGlassHack = UsingGlassHack,
    
                            physicsignore = {
                                Services.Workspace.Players,
                                Services.Workspace.Terrain,
                                Services.Workspace.Ignore,
                                Services.Workspace.CurrentCamera
                            },
    
                            onplayerhit = function(v50, v51, v52, v53, v54, v55)
                                Reversed.OnPlayerHitRebuilt(v50, v51, v52, "Head", v54, v55)
                            end,
                            
                            ontouch = function(...) Reversed.HitDetectionRebuilt(...) end,
    
                            extra = {
                                playersHit = {},
                                bulletTicket = FireCount,
                                firstHits = {},
                                firearmObject = weapon,
                                uniqueId = weapon.uniqueId
                            }
                        })

                        Bullets[i] = {
                            trajectory,
                            FireCount
                        }
                    end

                    weapon._fireCount = FireCount

                    -- NOTE: If we have suppresss shots on, This returns in network.
                    -- NOTE: This is only due to me wanting to still render bullet tracers.
                    Modules.NetworkClient:send("newbullets", weapon.uniqueId, {
                        camerapos = origin,
                        firepos = origin,
                        bullets = Bullets,
                    }, Modules.GameClock.getTime())

                    if not GetConfig("Ragebot Suppress Shots", "state") then
                        -- WARNING: Phantom Forces detects the interval between the time newbullets is recieved and bullethit.

                        if GetConfig("Ragebot Instant Hit") then
                            Features.Ragebot.BulletHit(sorted_targets, target, weapon, Bullets, destination)
                        else
                            local Task; Task = task.delay(time_hit, function()
                                Features.Ragebot.BulletHit(sorted_targets, target, weapon, Bullets, destination)
                                Task:despawn()
                            end)
                        end

                        weapon._magCount -= 1
                        weapon._nShots += 1
                    end

                    Modules.HudStatusInterface.updateAmmo(weapon)

                    do
                        local OldNextShot = weapon._nextShot

                        weapon._nextShot = Modules.GameClock.getTime()

                        if GetConfig("Firerate", "state") then
                            weapon._nextShot = Features.Ragebot.BestFirerate(weapon)
                        else
                            if weapon._burst <= 0 and weapon:getWeaponStat("firecap") and (weapon:getFiremode() ~= true and weapon:getFiremode() ~= 1) then
                                weapon._nextShot = Modules.GameClock.getTime() + 60 / weapon:getWeaponStat("firecap")
                            elseif weapon:getWeaponStat("autoburst") and weapon._auto and weapon._nShots < weapon:getWeaponStat("autoburst") then
                                weapon._nextShot = weapon._nextShot + 60 / weapon:getWeaponStat("burstfirerate")
                            elseif weapon:isAiming() and weapon:getActiveAimStat("aimedfirerate") then
                                weapon._nextShot = weapon._nextShot + 60 / weapon:getActiveAimStat("aimedfirerate")
                            else
                                weapon._nextShot = weapon._nextShot + 60 / weapon:getFirerate()
                            end
                        end
                
                        weapon._nextShot = OldNextShot + (weapon._nextShot - OldNextShot)
                    end

                    if weapon._characterObject.animating then
                        weapon._inspecting = false

                        weapon:cancelAnimation(weapon._reloadCancelTime)
                    end
    
                    local WeaponType = weapon:getWeaponStat("type")

                    task.delay(0.4, function()
                        if WeaponType == "REVOLVER" and not weapon:getWeaponStat("caselessammo") then
                            Modules.AudioSystem.play("metalshell", 0.1)
                        elseif WeaponType == "SHOTWeapon" then
                            Modules.AudioSystem.play("shotWeaponshell", 0.2)
                        elseif WeaponType == "SNIPER" then
                            weapon:playAnimation("pullbolt", true, true)
        
                            Modules.AudioSystem.play("metalshell", 0.15, 0.8)
                        end
                    end)
    
                    if weapon:getWeaponStat("sniperbass") then
                        Modules.AudioSystem.play("1PsniperBass", 0.75)
                        Modules.AudioSystem.play("1PsniperEcho", 1)
                    end
    
                    if not weapon:getWeaponStat("nomuzzleeffects") then
                        if Modules.PlayerSettingsInterface.getValue("firstpersonmuzzleffectsenabled") then
                            Modules.Effects.muzzleflash(
                                weapon._barrelPart, 
                                weapon:getWeaponStat("hideflash")
                            )
                        end
    
                        if not weapon:getWeaponStat("hideflash") then
                            weapon._characterObject:fireMuzzleLight()
                        end
                    end
    
                    if not weapon:getWeaponStat("hideminimap") then
                        Modules.HudSpottingInterface.goingLoud()
                    end

                    Modules.AudioSystem.playSoundId(
                        weapon:getWeaponStat("firesoundid"), 2,
                        weapon:getWeaponStat("firevolume"),
                        weapon:getWeaponStat("firepitch"),
                        weapon._barrelPart, nil, 0, 0.05
                    )

                    if weapon._magCount <= 0 then
                        Reversed.Reload(weapon)
                    end
                end

                Features.Ragebot.KnifeStep = function(targets, origin)
                    if GetConfig("Ragebot Suppress Shots", "state") then
                        return
                    end

                    local Distance = GetConfig("Ragebot Knife Bot Distance", "value")
                    local VisibleOnly = GetConfig("Ragebot Knife Bot Visible Only", "state")

                    for _, target in targets do 
                        if (target.Position - origin).Magnitude > Distance then
                            continue
                        end

                        if VisibleOnly and not Libraries.Utilities.IsVisible(origin, target.Position) then
                            continue
                        end
    
                        Modules.NetworkClient:send("stab")
                        Modules.NetworkClient:send("knifehit", target.Player, "Head", target.Position, Modules.GameClock.getTime())
                    end
                end
    
                Features.Ragebot.Step = function(character_object, firearm_object)
                    if not GetConfig("Ragebot Enabled", "state") then
                        return
                    end

                    if Reversed.IsRoundPaused() then
                        return
                    end

                    if not (character_object and character_object._rootPart) then
                        return
                    end

                    if Modules.RoundSystemClientInterface.roundLock then
                        return
                    end

                    Features.Ragebot.ActiveTarget = nil

                    local Origin, ViewAngles = PlayerInformation.LocalPlayer.Position, PlayerInformation.LocalPlayer.ViewAngles

                    -- Cache filtered targets only when we start a new scan
                    if Features.Ragebot.ProcessedTargetIndex <= 1 or not Features.Ragebot.CachedTargets then
                        local FilteredTargets = Features.Ragebot.FilterTargets(PlayerInformation.Players, Origin, ViewAngles,
                            GetConfig("Ragebot Limit Fov", "state") and GetConfig("Ragebot Maximum Fov", "value") or 180,
                            GetConfig("Ragebot Limit Distance", "state"), GetConfig("Ragebot Maximum Distance", "value")
                        )

                        local IsKnife = firearm_object:getWeaponType() == "Melee"

                        Features.Ragebot.CachedTargets = Features.Ragebot.SortTargets(FilteredTargets, Origin, 
                            IsKnife and "Distance" or GetConfig("Ragebot Sorting Mode", "value")
                        )

                        if IsKnife then
                            if GetConfig("Ragebot Knife Bot", "state") then
                                Features.Ragebot.KnifeStep(Features.Ragebot.CachedTargets, Origin)
                            end

                            return
                        end
                    end

                    if not Reversed.CanFire(firearm_object, true) then
                        return
                    end

                    -- NOTE: Generate fire positions only when starting a new scan
                    if Features.Ragebot.ProcessedTargetIndex <= 1  then 
                        Features.Ragebot.FirePositions = {}

                        if GetConfig("Ragebot Fire Position Scanning", "state") then
                            Features.Ragebot.FirePositions = Features.Ragebot.GenerateSpherePositions(
                                Features.Ragebot.FirePositions, Origin, GetConfig("Ragebot Performance Mode", "state"),
                                GetConfig("Ragebot Fire Position Scanning Distance", "value"),
                                GetConfig("Ragebot Fire Position Scanning Randomization", "state")
                            )
                        end
                    end

                    local LimitTargetsPerTick = GetConfig("Ragebot Limit Targets Per Tick", "state")
                    local TargetLimit = GetConfig("Ragebot Limit Targets Per Tick Amount", "value")

                    local BulletCheckTimeStep = 1 / GetConfig("Ragebot BulletCheck Time Step", "value")

                    local MaximumPenetrations = GetConfig("Ragebot Maximum Penetrations", "value")

                    local LimitDamage = GetConfig("Ragebot Limit Damage", "value")
                    local MinimumDamage = GetConfig("Ragebot Minimum Damage", "value")
                    local ScaleDamage = GetConfig("Ragebot Scale Damage", "state")

                    local BulletSpeed = firearm_object:getWeaponStat("bulletspeed") or 0

                    local PenetrationDepth = GetConfig("Ragebot Automatic Penetration", "state") 
                        and (firearm_object:getWeaponStat("penetrationdepth") or 0) or 0

                    local MultHead = firearm_object:getWeaponStat("multhead")
                    local DamageGraph = firearm_object:getWeaponStat("damageGraph")

                    local AutomaticFire = GetConfig("Ragebot Automatic Fire", "state")

                    local StartingTargetIndex = Features.Ragebot.ProcessedTargetIndex

                    for target_index = StartingTargetIndex, #Features.Ragebot.CachedTargets do
                        if LimitTargetsPerTick and (target_index - StartingTargetIndex) > TargetLimit then
                            Features.Ragebot.ProcessedTargetIndex = target_index
                            break
                        end

                        local Target = Features.Ragebot.CachedTargets[target_index]

                        local Origin, Destination, CanHit, Trajectory, TimeHit = Features.Ragebot.IsPenetrable(
                            Features.Ragebot.FirePositions, Target.TargetPositions, Vector3.zero, 
                            PenetrationDepth, BulletSpeed, MaximumPenetrations, BulletCheckTimeStep
                        )

                        if not CanHit then
                            continue
                        end

                        if LimitDamage then
                            local TargetHealth = Target.Entry:getHealth()

                            if ScaleDamage and MinimumDamage >= TargetHealth then
                                MinimumDamage = TargetHealth
                            end

                            if Modules.WeaponUtils.interpolateDamageGraph(
                                DamageGraph, (Destination - Origin).Magnitude
                            ) * (MultHead or 1.5) < MinimumDamage then
                                continue
                            end
                        end

                        Features.Ragebot.ProcessedTargetIndex = 1

                        if AutomaticFire then
                            Features.Ragebot.Shoot(
                                Features.Ragebot.CachedTargets, firearm_object, Target,
                                Trajectory, TimeHit, Origin, Destination
                            )
                        else
                            Features.Ragebot.ActiveTarget = {
                                Player = Target.Player,

                                Origin = Origin,
                                Destination = Destination,
                                Trajectory = Trajectory,
                                TimeHit = TimeHit
                            }
                        end

                        Features.Ragebot.CachedTargets = nil

                        return
                    end

                    if Features.Ragebot.ProcessedTargetIndex >= #Features.Ragebot.CachedTargets then
                        Features.Ragebot.ProcessedTargetIndex = 1
                        Features.Ragebot.CachedTargets = nil
                    end
                end
            end
        end

        do --  NOTE: Esp:
            -- TODO: Recode all of this in baseplate now that I know how roblox gui works.

            Features.Esp = {
                Gui = Libraries.Utilities.CreateInstance("ScreenGui", Services.CoreGui, {
                    IgnoreGuiInset = true
                }),

                Layouts = {}
            } do
                Features.Esp.BoxSizing = function(replication_postion, position, torso)
                    local _, OnScreen = Camera:WorldToViewportPoint(
                        (replication_postion or torso.Position) + (torso.CFrame.UpVector * 1.8) + Camera.CFrame.UpVector
                    )

                    local Top, _ = Camera:WorldToViewportPoint(
                        (position or torso.Position) + (torso.CFrame.UpVector * 1.8) + Camera.CFrame.UpVector
                    )

                    local Bottom, _ = Camera:WorldToViewportPoint(
                        (position or torso.Position) - (torso.CFrame.UpVector * 2.5) - Camera.CFrame.UpVector
                    )
            
                    local Width = math.max(math.floor(math.abs(
                        Top.X - Bottom.X)
                    ), 3)

                    local Height = math.max(math.floor(math.max(math.abs(
                        Bottom.Y - Top.Y),
                        Width / 2
                    )), 3)
                    
                    local BoxSize = Vector2.new(
                        math.floor(math.max(Height / 1.5, Width)),
                        Height
                    )

                    local BoxPosition = Vector2.new(
                        math.floor(Top.X * 0.5 + Bottom.X * 0.5 - BoxSize.X * 0.5),
                        math.floor(math.min(Top.Y, Bottom.Y))
                    )
                    
                    return BoxSize, BoxPosition, OnScreen
                end

                Features.Esp.CreateLayout = function(player)
                    if player == LocalPlayer then
                        return
                    end

                    local PlayerInstance = Features.Esp.Layouts[player.Name]

                    if PlayerInstance then
                        return
                    end

                    setthreadidentity(7)

                    do -- Layout
                        local Layout = {}

                        Layout.Frame = Libraries.Utilities.CreateInstance("Frame", Features.Esp.Gui, {
                            BackgroundTransparency = GetConfig("ESP Player Box", "state") and GetConfig("ESP Player Box Fill", "state") and
                                (1 - GetConfig("ESP Player Box Fill Color", "trans")) or 1,

                            BackgroundColor3 = GetConfig("ESP Player Box Fill Color", "color") or Color3.fromRGB(255, 255, 255),

                            Position = UDim2.new(0, 0, 0, 0),
                            Size = UDim2.new(0, 0, 0, 0),

                            Name = player.Name,
                            Visible = false
                        })
    
                        do -- Box
                            do -- Frames
                                Layout.BoxOutlineFrame = Libraries.Utilities.CreateInstance("Frame", Layout.Frame, {
                                    Name = "BoxOutlineFrame",
                                    BackgroundTransparency = 1,
                                    Position = UDim2.new(0, -1, 0, -1),
                                    Size = UDim2.new(1, 2, 1, 2),
                                    Visible = true,
                                })
                                
                                Layout.BoxInlineFrame = Libraries.Utilities.CreateInstance("Frame", Layout.Frame, {
                                    Name = "BoxInlineFrame",
                                    BackgroundTransparency = 1,
                                    Position = UDim2.new(0, 1, 0, 1),
                                    Size = UDim2.new(1, -2, 1, -2),
                                    Visible = true,
                                })
                            end

                            do -- UI Strokes
                                local BoxTransparency = GetConfig("ESP Player Box Color", "trans") or 0

                                if BoxTransparency then
                                    BoxTransparency = 1 - BoxTransparency
                                end

                                do -- Middle
                                    Layout.Box = Libraries.Utilities.CreateInstance("UIStroke", Layout.Frame, {
                                        Name = "Box",
                                        Enabled = GetConfig("ESP Player Box", "state") or false,
                                        Color = GetConfig("ESP Player Box Color", "color") or Color3.fromRGB(255, 255, 255),
                                        Transparency = BoxTransparency,
                                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                                        LineJoinMode = Enum.LineJoinMode.Miter,
                                        Thickness = 1,
                                    })
                                end
                                
                                do -- Outer
                                    Layout.BoxOuter = Libraries.Utilities.CreateInstance("UIStroke", Layout.BoxOutlineFrame, {
                                        Name = "Box Outer",
                                        Enabled = GetConfig("ESP Player Box", "state") or false,
                                        Color = Color3.fromRGB(0, 0, 0),
                                        Transparency = BoxTransparency,
                                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                                        LineJoinMode = Enum.LineJoinMode.Miter,
                                        Thickness = 1,
                                    })
                                end
                                
                                do -- Inner
                                    Layout.BoxInner = Libraries.Utilities.CreateInstance("UIStroke", Layout.BoxInlineFrame, {
                                        Name = "Box Inner",
                                        Enabled = GetConfig("ESP Player Box", "state") or false,
                                        Color = Color3.fromRGB(0, 0, 0),
                                        Transparency = BoxTransparency,
                                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                                        LineJoinMode = Enum.LineJoinMode.Miter,
                                        Thickness = 1,
                                    })
                                end
                            end 
                        end
                
                        Layout.Name = Libraries.Utilities.CreateInstance("TextLabel", Layout.Frame, {
                            Visible = GetConfig("ESP Player Name", "state") or false,

                            TextColor3 = GetConfig("ESP Player Name Color", "color") or Color3.fromRGB(255, 255, 255),
                            TextStrokeTransparency = 1 - (GetConfig("ESP Player Name Color", "trans") or 0),
                            BackgroundTransparency = 1,

                            AnchorPoint = Vector2.new(0.5, 0.5),

                            Position = UDim2.new(0.5, 0, 0, -10),
                            Size = UDim2.new(0.5, 0, 0.5, 0),

                            FontFace = Font.new(Libraries.Fonts.Proggyclean),
                            Text = player.Name,
                            TextSize = 10
                        })
                        
                        do -- Health bar
                            Layout.HealthBackground = Libraries.Utilities.CreateInstance("Frame", Layout.Frame, {
                                Visible = GetConfig("ESP Player Health", "state") or false,
                                
                                BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                BackgroundTransparency = 0,

                                Position = UDim2.new(0, -6, 0, -1),
                                Size = UDim2.new(0, 2, 1, 2)
                            })
                            
                            Layout.HealthFrame = Libraries.Utilities.CreateInstance("Frame", Layout.HealthBackground, {
                                Visible = GetConfig("ESP Player Health", "state") or false,

                                BackgroundColor3 = GetConfig("ESP Player Health Color", "color") or Color3.fromRGB(255, 255, 255),
                                BackgroundTransparency = 0,

                                Position = UDim2.new(0, 0, 0, 0),
                                Size = UDim2.new(1, 0, 1, 0)
                            })

                            Layout.HealthStroke = Libraries.Utilities.CreateInstance("UIStroke", Layout.HealthFrame, {
                                Enabled = true,

                                Color = Color3.fromRGB(0, 0, 0),
                                Transparency = 0,

                                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                                LineJoinMode = Enum.LineJoinMode.Miter
                            })

                            Layout.HealthNumber = Libraries.Utilities.CreateInstance("TextLabel", Layout.HealthFrame, {
                                TextColor3 = GetConfig("ESP Player Health Color", "color") or Color3.fromRGB(255, 255, 255),
                                Visible = GetConfig("ESP Player Health", "state") or false,
    
                                TextStrokeTransparency = 1 - (GetConfig("ESP Player Health Color", "trans") or 0),
                                BackgroundTransparency = 1,
    
                                TextXAlignment = Enum.TextXAlignment.Right,
                                Position = UDim2.new(0, -4, 0, 0),
                                Size = UDim2.new(0, 0, 0, 0),
    
                                FontFace = Font.new(Libraries.Fonts.Proggyclean),
                                TextSize = 10,
                                Text = "???"
                            })
                        end
                        
                        Layout.Weapon = Libraries.Utilities.CreateInstance("TextLabel", Layout.Frame, {
                            TextColor3 = GetConfig("ESP Player Weapon Color", "color") or Color3.fromRGB(255, 255, 255),
                            Visible = GetConfig("ESP Player Weapon", "state") or false,

                            TextStrokeTransparency = 1 - (GetConfig("ESP Player Weapon Color", "trans") or 0),
                            BackgroundTransparency = 1,

                            AnchorPoint = Vector2.new(0.5, 0.5),

                            Position = UDim2.new(0.5, 0, 1, 8),
                            Size = UDim2.new(0.5, 0, 0.5, 0),

                            FontFace = Font.new(Libraries.Fonts.Proggyclean),
                            TextSize = 10,
                            Text = "???"
                        })

                        Layout.Update = LPH_JIT_MAX(function(self, entry, thirdperson_object, replication_postion, character_position, is_teammate, config)
                            if not thirdperson_object._torso then
                                return
                            end

                            if config.LimitDistance and (replication_postion - PlayerInformation.LocalPlayer.Position).Magnitude > config.DistanceLimit then
                                self.Frame.Visible = false
                                return
                            end

                            local BoxSize, BoxPosition, OnScreen = Features.Esp.BoxSizing(replication_postion, character_position, thirdperson_object._torso)

                            if is_teammate and not config.ShowTeammates then
                                self.Frame.Visible = false
                                return
                            else
                                self.Frame.Visible = entry:isAlive() and OnScreen and config.Enabled
                            end

                            if config.VisibleOnly and not Libraries.Utilities.IsVisible(Camera.CFrame.Position, replication_postion) then
                                self.Frame.Visible = false
                                return
                            end

                            self.Frame.Position = UDim2.fromOffset(BoxPosition.X, BoxPosition.Y)
                            self.Frame.Size = UDim2.fromOffset(BoxSize.X, BoxSize.Y)

                            local Health = entry:getHealth()
                            local HealthScale = Health / 100

                            self.HealthFrame.BackgroundColor3 = Libraries.Utilities.InterpolateColor(
                                config.HealthFullColor, config.HealthLowColor, 1 - HealthScale
                            )

                            self.HealthFrame.Position = UDim2.new(0, 0, 1 - HealthScale, 0)
                            self.HealthFrame.Size = UDim2.new(1, 0, HealthScale, 0)

                            self.HealthNumber.Text = tostring(math.floor(Health))

                            self.Weapon.Text = thirdperson_object._weaponName or "???"
                        end)

                        Features.Esp.Layouts[player.Name] = Layout
                    end
                end

                Features.Esp.DestroyLayout = function(player)
                    local Layout = Features.Esp.Layouts[player.Name]

                    if not Layout then
                        return
                    end
                    
                    setthreadidentity(7)
                    
                    for _, instance in Layout.Frame:GetChildren() do
                        instance:Destroy()
                    end

                    Layout.Frame:Destroy()
                    
                    Features.Esp.Layouts[player.Name] = nil
                end

                Features.Esp.Step = function()
                    setthreadidentity(7)

                    local FollowServerPosition = GetConfig("ESP Follow Server Position", "state")
                    local LimitDistance, DistanceLimit = GetConfig("ESP Limit Distance", "state"), GetConfig("ESP Distance Limit", "value")

                    for player_name, layout in Features.Esp.Layouts do
                        local PlayerInformation = PlayerInformation.GetPlayerByName(player_name)

                        if not PlayerInformation then
                            layout.Frame.Visible = false
                            continue
                        end

                        local TorsoPosition = PlayerInformation.ThirdPersonObject._torso.Position
                        local PlayerPosition = FollowServerPosition and PlayerInformation.Position or TorsoPosition

                        layout:Update(
                            PlayerInformation.Entry, 
                            PlayerInformation.ThirdPersonObject, 
                            PlayerInformation.Position, PlayerPosition,
                            PlayerInformation.Player.Team == LocalPlayer.Team, {
                                Enabled = GetConfig("ESP Enabled", "state") or false,
                                VisibleOnly = GetConfig("ESP Visible Only", "state") or false,
                                ShowTeammates = GetConfig("ESP Show Teammates", "state") or false,
                                HealthFullColor =  GetConfig("ESP Player Health Full Color", "color") or Color3.new(),
                                HealthLowColor = GetConfig("ESP Player Health Color", "color") or Color3.new(),
                                LimitDistance = LimitDistance, DistanceLimit = DistanceLimit
                            }
                        )
                    end
                end

                Features.Esp.UpdateInstance = function(names, properties)
                    for _, layout in Features.Esp.Layouts do
                        if table.find(names, "Frame") then
                            for property_name, property_value in properties do
                                layout.Frame[property_name] = property_value
                            end
                        end

                        for instance_name, instance in layout do
                            if not table.find(names, instance_name) then
                                continue
                            end

                            for property_name, property_value in properties do
                                instance[property_name] = property_value
                            end
                        end
                    end
                end

                Features.Esp.Destroy = function()
                    Features.Esp.Gui:Destroy()
                end

                for _, player in Services.Players:GetPlayers() do
                    Features.Esp.CreateLayout(player)
                end
            end
        end

        do --  NOTE: Highlights
            -- FATAL: Using 'Toggle Ragdolls' in game causes it to highlight parts of the ragdolls (buggy af)

            Features.Highlights = {
                Folder = Libraries.Utilities.CreateInstance("Folder", Services.Workspace.Ignore, {
                    Name = "Highlights"
                })
            }; do
                Features.Highlights.PlayersFolder = Libraries.Utilities.CreateInstance("Model", Features.Highlights.Folder, {
                    Name = "Players"
                })

                Features.Highlights.PlayersHighlight = Libraries.Utilities.CreateInstance("Highlight", Features.Highlights.PlayersFolder, {
                    Adornee = Features.Highlights.PlayersFolder,
                    Enabled = false
                })

                Features.Highlights.WeaponHighlight = Libraries.Utilities.CreateInstance("Highlight", Features.Highlights.Folder, {
                    DepthMode = Enum.HighlightDepthMode.Occluded,
                    Enabled = false
                })

                Features.Highlights.ArmsFolder = Libraries.Utilities.CreateInstance("Model", Features.Highlights.Folder, {
                    Name = "Arms"
                })

                Features.Highlights.ArmsHighlight = Libraries.Utilities.CreateInstance("Highlight", Features.Highlights.ArmsFolder, {
                    DepthMode = Enum.HighlightDepthMode.Occluded,
                    Adornee = Features.Highlights.ArmsFolder,
                    Enabled = false
                })
                
                Features.Highlights.Destroy = function()
                    for _, instance in Features.Highlights.ArmsFolder:GetChildren() do
                        instance.Parent = Services.Workspace.Camera    
                    end

                    Modules.ReplicationInterface.operateOnAllEntries(function(player, entry)
                        local ThirdPersonObject = entry:getThirdPersonObject()

                        if ThirdPersonObject then
                            local CharacterModel = ThirdPersonObject:getCharacterModel()

                            if CharacterModel then
                                CharacterModel.Parent = Modules.TeamConfig.getTeamFolder(player.TeamColor)
                            end
                        end
                    end)

                    Features.Highlights.Folder:Destroy()
                    Features.Highlights.PlayersFolder:Destroy()
                    Features.Highlights.ArmsFolder:Destroy()

                    Features.Highlights.PlayersHighlight:Destroy()
                    Features.Highlights.WeaponHighlight:Destroy()
                    Features.Highlights.ArmsHighlight:Destroy()
                end
            end
        end

        do --  NOTE: Chams
            Features.ChamsManager = {
                OriginalModels = {},

                PropertiesToStore = {
                    "Material", "TextureID",
                    "Color", "Transparency"
                }
            }; do
                -- Mmmmm I like tables
                Features.ChamsManager.StoreOriginal = function(model)
                    Features.ChamsManager.OriginalModels[model] = {}

                    for _, part in model:GetChildren() do
                        Features.ChamsManager.OriginalModels[model][part] = {}
                        
                        if part.Name == "Sleeves" then
                            Features.ChamsManager.OriginalModels[model][part] = {
                                Transparency = part.Transparency,
                                Textures = {}
                            }
                            
                            for _, texture in part:GetChildren() do
                                Features.ChamsManager.OriginalModels[model][part].Textures[texture] = texture.Transparency
                            end
                            
                            continue
                        end
                        
                        for _, property_name in Features.ChamsManager.PropertiesToStore do
                            local HasProperty = pcall(function()
                                return part[property_name]
                            end)

                            if HasProperty then
                                Features.ChamsManager.OriginalModels[model][part][property_name] = part[property_name]
                            end
                        end
                    end
                end

                Features.ChamsManager.Apply = function(models, config)
                    for _, model in models do
                        if not Features.ChamsManager.OriginalModels[model] then
                            Features.ChamsManager.StoreOriginal(model)
                        end

                        for _, part in model:GetChildren() do
                            if config.Filter and not config.Filter(part) then
                                continue
                            end

                            if part.Transparency == 1 then
                                continue
                            end

                            if part.Name == "Sleeves" then
                                part.LocalTransparencyModifier = 1

                                for _, texture in part:GetChildren() do
                                    texture.LocalTransparencyModifier = 1
                                end

                                continue
                            end

                            local HasProperty = pcall(function()
                                return part.UsePartColor
                            end)

                            if HasProperty then  
                                part.UsePartColor = true
                            end
                            
                            for property_name, value in config.Properties do
                                HasProperty = pcall(function()
                                     return part[property_name]
                                end)

                                if HasProperty then
                                    part[property_name] = value
                                end
                            end
                        end
                    end
                end

                Features.ChamsManager.Restore = function(models)
                    for _, model in models do
                        if not Features.ChamsManager.OriginalModels[model] then
                            continue
                        end
                
                        for part, properties in Features.ChamsManager.OriginalModels[model] do
                            if part.Name == "Sleeves" then
                                part.LocalTransparencyModifier = properties.Transparency

                                local HasProperty = pcall(function()
                                    return part.TextureID
                                end)

                                if HasProperty and properties.TextureID then
                                    part.TextureID = properties.TextureID
                                end

                                for texture, transparency in properties.Textures do
                                    texture.LocalTransparencyModifier = transparency
                                end
                
                                continue
                            end
                            
                            for property_name, value in properties do
                                part[property_name] = value
                            end
                        end
                    end
                end

                Features.ChamsManager.ArmsStep = function(character_object)
                    character_object = character_object or Modules.CharacterInterface.getCharacterObject()

                    if not character_object then
                        return
                    end

                    local LeftArm, RightArm = character_object:getArmModels()

                    LeftArm.Parent = Features.Highlights.ArmsFolder
                    RightArm.Parent = Features.Highlights.ArmsFolder

                    if GetConfig("Arm Chams", "state") then
                        Features.ChamsManager.Apply({LeftArm, RightArm}, {
                            Filter = nil,
    
                            Properties = {
                                Color = GetConfig("Arm Chams Color", "color"),
                                Transparency = 1 - GetConfig("Arm Chams Color", "trans"),
                                Material = Cheat.Materials[GetConfig("Arm Chams Material", "value")],
                                TextureID = Cheat.Textures[GetConfig("Arm Chams Texture", "value")]
                            }
                        })
                    else
                        Features.ChamsManager.Restore({
                            LeftArm, 
                            RightArm
                        })
                    end
                end

                Features.ChamsManager.WeaponStep = function(firearm_object)
                    firearm_object = firearm_object or Reversed.GetFirearmObject()

                    if not firearm_object then
                        return
                    end

                    local WeaponModel = firearm_object:getWeaponModel()

                    if WeaponModel and GetConfig("Weapon Chams", "state") then
                        Features.Highlights.WeaponHighlight.Adornee = WeaponModel
                        
                        -- NOTE: I'm SUPPOSE to check for the weapon transparency not the config but it somehow works.
                        local Transparency = 1 - GetConfig("Weapon Chams Color", "trans")

                        if Transparency == 1 then
                            Transparency = 1.01
                        end
                        
                        Features.ChamsManager.Apply({WeaponModel}, {
                            Filter = function(instance)
                                if not firearm_object._weaponData or not firearm_object._weaponData.invisible then
                                    return true
                                end
                                
                                return firearm_object._weaponData.invisible[instance.Name] == nil
                            end,
                            
                            Properties = {
                                Color = GetConfig("Weapon Chams Color", "color"),
                                Transparency = Transparency,
                                Material = Cheat.Materials[GetConfig("Weapon Chams Material", "value")],
                                TextureID = Cheat.Textures[GetConfig("Weapon Chams Texture", "value")]
                            }
                        })
                    else
                        Features.ChamsManager.Restore({WeaponModel})
                    end
                end

                Features.ChamsManager.Destroy = function()
                    local FirearmObject = Reversed.GetFirearmObject()

                    if FirearmObject then
                        Features.ChamsManager.Restore({FirearmObject:getWeaponModel()})
                    end

                    local CharacterObject = Modules.CharacterInterface.getCharacterObject()

                    if CharacterObject then
                        local LeftArm, RightArm = CharacterObject:getArmModels()
                    
                        Features.ChamsManager.Restore({LeftArm, RightArm})
                    end
                end
            end
        end

        do --  NOTE: Lighting
            Features.Lighting = {

            }; do
                Features.Lighting.OverrideAmbients = function(is_setuplighting)
                    if is_setuplighting then
                        Features.Lighting.OriginalAmbients = {
                            Ambient = Services.Lighting.Ambient,
                            OutdoorAmbient = Services.Lighting.OutdoorAmbient,
                            ColorShift_Top = Services.Lighting.ColorShift_Top,
                            ColorShift_Bottom = Services.Lighting.ColorShift_Bottom
                        }
                    end

                    if GetConfig("Ambient Lighting", "state") then
                        if not Features.Lighting.OriginalAmbients then
                            Features.Lighting.OriginalAmbients = {
                                Ambient = Services.Lighting.Ambient,
                                OutdoorAmbient = Services.Lighting.OutdoorAmbient,
                                ColorShift_Top = Services.Lighting.ColorShift_Top,
                                ColorShift_Bottom = Services.Lighting.ColorShift_Bottom
                            }
                        end

                       local Color = GetConfig("Ambient Lighting Color", "color")

                        Services.Lighting.Ambient = Color
                        Services.Lighting.OutdoorAmbient = Color
                        Services.Lighting.ColorShift_Top = Color
                        Services.Lighting.ColorShift_Bottom = Color
                    elseif Features.Lighting.OriginalAmbients then
                        for property_name, value in Features.Lighting.OriginalAmbients do
                            Services.Lighting[property_name] = value
                        end

                        Features.Lighting.OriginalAmbients = nil
                    end
                end

                Features.Lighting.OverrideDLights = function()
                    if not GetConfig("Direct Lighting", "state") then
                        return
                    end

                    local MapParts = Services.Workspace:FindFirstChild("Map")

                    if not MapParts then
                        return
                    end

                    MapParts = Map:FindFirstChild("MapParts")

                    if not MapParts then
                        return
                    end

                    for _, property in ipairs(MapParts:GetDescendants()) do
                        if not (property.ClassName == "PointLight" or property.ClassName == "SurfaceLight" or property.ClassName == "SpotLight") then
                            return
                        end
        
                        property.Parent.Color = GetConfig("Direct Lighting Color", "color")
                        property.Color = GetConfig("Direct Lighting Color", "color")

                        property.Brightness = GetConfig("Direct Lighting Brightness", "value")
                        property.Range = GetConfig("Direct Lighting Range", "value")
                    end
                end
                
                Features.Lighting.OverrideSkybox = function()
                    local Skybox = Libraries.Utilities.FindFirstDescendantOfClass(Services.Lighting, "Sky")

                    if Skybox then
                        local Original = Features.Lighting.SkyboxOriginal

                        if GetConfig("Skybox Changer", "state") then
                            if not Original then
                                Features.Lighting.SkyboxOriginal = {
                                    CelestialBodiesShown = Skybox.CelestialBodiesShown,   
    
                                    Faces = {
                                        SkyboxBk = Skybox.SkyboxBk, SkyboxDn = Skybox.SkyboxDn, 
                                        SkyboxFt = Skybox.SkyboxFt, SkyboxLf = Skybox.SkyboxLf, 
                                        SkyboxRt = Skybox.SkyboxRt, SkyboxUp = Skybox.SkyboxUp
                                    }
                                }
                            end

                            Skybox.CelestialBodiesShown = GetConfig("Celestial Bodies", "state")
                            Skybox.StarCount = 0

                            for property_name, value in Cheat.Skyboxes[GetConfig("Skybox", "value")] do
                                Skybox[property_name] = value
                            end
                        elseif Original then
                            Skybox.CelestialBodiesShown = Original.CelestialBodiesShown

                            for property_name, value in Original.Faces do
                                Skybox[property_name] = value
                            end

                            Features.Lighting.SkyboxOriginal = nil
                        end
                    end
                end

                Features.Lighting.OverrideBloom = function()
                    local BloomEffect = Libraries.Utilities.FindFirstDescendantOfClass(Services.Lighting, "BloomEffect") or Libraries.Utilities.CreateInstance("BloomEffect", Services.Lighting, {
                        Name = "CustomBloom"
                    })

                    local BloomEnabled = GetConfig("Bloom", "state")

                    if BloomEnabled then
                        if BloomEffect.Name ~= "CustomBloom" and not Features.Lighting.BloomOriginal then
                            Features.Lighting.BloomOriginal = {
                                Enabled = BloomEffect.Enabled,
                                Intensity = BloomEffect.Intensity,
                                Threshold = BloomEffect.Threshold,
                                Size = BloomEffect.Size
                            }
                        end

                        BloomEffect.Enabled = BloomEnabled
                        BloomEffect.Intensity = GetConfig("Bloom Intensity", "value")
                        BloomEffect.Threshold = GetConfig("Bloom Threshold", "value")
                        BloomEffect.Size = GetConfig("Bloom Size", "value")
                    elseif not BloomEnabled and Features.Lighting.BloomOriginal then
                        for property_name, value in Features.Lighting.BloomOriginal do
                            BloomEffect[property_name] = value
                        end

                        Features.Lighting.BloomOriginal = nil
                    end
                end

                Features.Lighting.SetupLighting = LPH_JIT_MAX(function()
                    setthreadidentity(7)

                    Services.Lighting.Technology = GetConfig("Technology", "value")
    
                    if GetConfig("Override Sun Brightness", "state") then
                        Services.Lighting.Brightness = GetConfig("Sun Brightness", "value") / 100
                    end

                    if GetConfig("Override Clock Time", "state") then
                        Services.Lighting.ClockTime = GetConfig("Clock Time", "value")
                    end

                    Features.Lighting.OverrideAmbients(true)
                    Features.Lighting.OverrideDLights()
                    Features.Lighting.OverrideSkybox()
                    Features.Lighting.OverrideBloom()
                end)

                Features.Lighting.Destroy = function()
                    local Skybox = Libraries.Utilities.FindFirstDescendantOfClass(Services.Lighting, "Sky")
                    local OriginalSkybox = Features.Lighting.SkyboxOriginal

                    if Skybox and OriginalSkybox then
                        local OriginalSkybox = Features.Lighting.SkyboxOriginal

                        Skybox.CelestialBodiesShown = OriginalSkybox.CelestialBodiesShown

                        for property_name, value in OriginalSkybox.Faces do
                            Skybox[property_name] = value
                        end

                        Features.Lighting.SkyboxOriginal = nil
                    end

                    local OriginalAmbients = Features.Lighting.OriginalAmbients

                    if OriginalAmbients then
                        for property_name, value in Features.Lighting.OriginalAmbients do
                            Services.Lighting[property_name] = value
                        end
                    end
                end
            end
        end

        do --  NOTE: Misc
            -- NOTE: Nothing in here is really that big, we just do them on the hooks.

            Features.Misc = {
                LastMessageTime = 0,
                LastSpawnTime = 0,
                LastDeployAttempt = 0,
            }; do
                Features.Misc.AutoDeploy = function(character_object)
                    if character_object then
                        return
                    end

                    local ClockTime = os.clock()

                    if Features.Misc.LastDeployAttempt > ClockTime then
                        return
                    end

                    Features.Misc.LastDeployAttempt = ClockTime + 1

                    Modules.NetworkClient:send("spawn", Modules.RoundSystemClientUtils:getSpawn())
                end

                Features.Misc.ChatSpammer = function()
                    local ClockTime = os.clock()

                    if Features.Misc.LastMessageTime > ClockTime then
                        return
                    end
    
                    Features.Misc.LastMessageTime = ClockTime + GetConfig("Chat Spammer Delay", "value")
    
                    local Mode, Message = GetConfig("Chat Spammer Mode", "value")
    
                    if Mode == "Custom" then
                        Message = GetConfig("Chat Spammer Message", "value")
                    else
                        local MessageList = Cheat.ChatMessages[Mode]
                        
                        Message = MessageList[math.random(0, #MessageList)]
                    end
    
                    Modules.NetworkClient:send("sendChatMessage", Message)
                end

                Features.Misc.Step = function(character_object)
                    if GetConfig("Auto Deploy", "state") then
                        Features.Misc.AutoDeploy(character_object)
                    end

                    if GetConfig("Chat Spammer", "state") then
                        Features.Misc.ChatSpammer()
                    end
                end

                Features.Misc.Destroy = function()
                    local CharacterObject = Modules.CharacterInterface.getCharacterObject()

                    if CharacterObject then
                        CharacterObject.unaimedfov = Modules.SettingsFieldOfView.defaultValue
                    end
                end
            end
        end
    end

    do -- NOTE: Connections
        Modules.RenderSteppedUpdater:add(LPH_NO_VIRTUALIZE(function()
            Features.Esp.Step()
        end) --[[, 1]])

        Libraries.Utilities.AddConnection("PlayerAdded",  Services.Players.PlayerAdded, function(player)
            Features.Esp.CreateLayout(player)
        end)

        Libraries.Utilities.AddConnection("PlayerRemoving", Services.Players.PlayerRemoving, function(player)
            PlayerInformation.RemovePlayer(player.Name)
            Features.Esp.DestroyLayout(player)
        end)
    end

    do -- NOTE: Hooks (30x)
        do -- NOTE: NetworkClient (1)
            Hooks.Callbacks = debug.getupvalue(Modules.NetworkClient.fireReady, 4)

            Hooks.Originals.NetworkClient = {
                send = Modules.NetworkClient.send
            }

            Hooks.Storage.WhitelistedCommands = {
                --[["flaguser", "debug", "logmessage",]] 
                "stance", "sprint", "falldamage", "forcereset", "changePlayerSetting",
                "updateBlueprintSlot", "purchaseBlueprintFromWeaponLoadoutRequest", "purchaseBlueprintSlot", 
                "changeAttachment", "resetAttachments", "changeMapVote", "changeModeVote", "requestPreviewTag",
                "purchaseTag", "changeTagColor", "sellSkin", "spawn", "votefromUI", "purchaseCredits", "teleportparty",
                "gameModeEvent", "servertype", "sendFormSubmission", "teleportwithdata", "newgrenade", "swapweapon",
                "purchaseDailyShopItemRequest", "changeClass", "changeWeapon", "squadspawnupdate", "togglesquadspawn", 
                "purchaseCaseCredit", "purchaseCaseKeyCredit", "requestRoll", "requestMultiRoll", "ping", "newbullets", 
                "bullethit", "repupdate", "equip", "stab", "knifehit", "spotplayers", "suppressionassist", "aim",
                "updatesight", "reload", "getammo", "breakwindow", "sendChatMessage", "purchaseWeapon",
                "skiponboarding", "enteredfreecam"
            }

            Modules.NetworkClient.send = LPH_NO_UPVALUES(function(self, command, ...)
                local Arguments = {...}

                if command == "newbullets" then
                    local ActiveTarget = Features.Ragebot.ActiveTarget

                    if ActiveTarget and not GetConfig("Ragebot Automatic Fire", "state") then
                        local FirearmObject = Reversed.GetFirearmObject()

                        local Trajectory = Reversed.Trajectory(
                            Arguments[2].firepos, ActiveTarget.Destination,
                            -Modules.PublicSettings.bulletAcceleration,
                            FirearmObject:getWeaponStat("bulletspeed") or 0
                        )

                        for i = 1, #Arguments[2].bullets do
                            Arguments[2].bullets[i][1] = Trajectory
                        end

                        if GetConfig("Ragebot Instant Hit", "state") then
                            for _, bullet in Arguments[2].bullets do
                                Modules.NetworkClient:send("bullethit", FirearmObject.uniqueId,
                                    ActiveTarget.Player, ActiveTarget.Destination, "Head",
                                    bullet[2], Modules.GameClock.getTime()
                                )
                            end
                        end

                        if GetConfig("Ragebot Suppress Shots", "state") then
                            return
                        end
                    end

                    if GetConfig("Local Bullet Tracers", "state") then
                        local Texture = Cheat.Tracers[GetConfig("Bullet Tracers Texture", "value")]
                        local TextureSpeed = GetConfig("Bullet Tracers Texture Speed", "value")
                        local Color = GetConfig("Local Bullet Tracers Color", "color")
                        local Time = GetConfig("Bullet Tracers Time", "value")

                        local Origin = Arguments[2].firepos

                        for _, bullet in Arguments[2].bullets do
                            -- TODO: Properly calculate the impact position.
                            local End = Origin + (type(bullet[1]) == "table" and bullet[1].unit.Unit or bullet[1].Unit) * 300

                            Libraries.Utilities.CreateBeam(Origin, End, Color, Time, Texture, TextureSpeed)
                        end
                    end
                elseif command == "bullethit" then
                    -- TODO: Do spoof hitbox here, just change Arguments[4] to the desired hitbox as a string.
                elseif command == "falldamage" and GetConfig("Remove Fall Damage", "state") then
                    return
                elseif command == "repupdate" then
                    PlayerInformation.LocalPlayer.Position = Arguments[1]
                    PlayerInformation.LocalPlayer.ViewAngles = Arguments[2]
                elseif command == "flaguser" or command == "debug" or command == "logmessage" then
                    return Libraries.Utilities.Log("FATAL", command .. " was triggered!")
                elseif not table.find(Hooks.Storage.WhitelistedCommands, command) then
                    return Libraries.Utilities.Log("FATAL", "Unknown command '" .. command .. "' was triggered!")
                end

                return Hooks.Originals.NetworkClient.send(self, command, table.unpack(Arguments))
            end)
        end

        do -- NOTE: NetworkClient callbacks (1)
            Hooks.Originals.Callbacks = {
                newbullets = Hooks.Callbacks.newbullets,
                bulletHitConfirm = Hooks.Callbacks.bulletHitConfirm,
                meleeHitConfirm = Hooks.Callbacks.meleeHitConfirm,
                grenadeHitConfirm = Hooks.Callbacks.grenadeHitConfirm,
                newspawn = Hooks.Callbacks.newspawn,
                died = Hooks.Callbacks.died,
                startvotekick = Hooks.Callbacks.startvotekick,
                correctposition = Hooks.Callbacks.correctposition
            }

            Hooks.Callbacks.newbullets = LPH_NO_UPVALUES(function(data)
                local Player = data.player

                if Player == LocalPlayer then
                    return
                end

                if Player.Team == LocalPlayer.Team then
                    return
                end

                if GetConfig("Enemy Bullet Tracers", "state") then
                    local Texture = Cheat.Tracers[GetConfig("Bullet Tracers Texture", "value")]
                    local TextureSpeed = GetConfig("Bullet Tracers Texture Speed", "value")
                    local Color = GetConfig("Enemy Bullet Tracers Color", "color")
                    local Time = GetConfig("Bullet Tracers Time", "value")

                    local Origin = data.firepos

                    for _, bullet in data.bullets do
                        Libraries.Utilities.CreateBeam(Origin, Origin + (bullet.velocity * 300), Color, Time, Texture, TextureSpeed)
                    end
                end

                return Hooks.Originals.Callbacks.newbullets(data)
            end)

            do -- Hit confirmation hooks
                Hooks.Functions.OnHit = function(player, hitbox_name, damage, clock_time)
                    if GetConfig("Event Logs", "state") and GetConfig("Events To Log", "value", "Hits") then 
                        local Message = "Hit " .. player.Name .. " in the " .. hitbox_name .. " for " .. math.round(damage)

                        if clock_time then
                            local Time = math.round((Modules.GameClock.getTime() - clock_time) * 1000)

                            Message ..= " (took " .. Time .. "ms)"
                        end

                        Libraries.Utilities.Log("Hit", Message)
                    end

                    if GetConfig("Hit Sound", "state") then
                        Modules.AudioSystem.playSoundId(
                            Cheat.Hitsounds[GetConfig("Hit Sound Name", "value")],
                            1, -- NOTE: This is our pitch but nobody is gonna change this.
                            GetConfig("Hit Sound Volume", "value") / 100
                        )
                    end
                end

                Hooks.Callbacks.bulletHitConfirm = LPH_NO_UPVALUES(function(player, hitbox_name, v35, damage, v37, clock_time)
                    Hooks.Functions.OnHit(player, hitbox_name, damage, clock_time)
    
                    return Hooks.Originals.Callbacks.bulletHitConfirm(player, hitbox_name, v35, damage, v37, clock_time)
                end)
    
                Hooks.Callbacks.meleeHitConfirm = LPH_NO_UPVALUES(function(player, hitbox_name, v35, damage, v37)
                    Hooks.Functions.OnHit(player, hitbox_name, damage)
    
                    return Hooks.Originals.Callbacks.meleeHitConfirm(player, hitbox_name, v35, damage, v37)
                end)
    
                Hooks.Callbacks.grenadeHitConfirm = LPH_NO_UPVALUES(function(player, hitbox_name, v35, damage, v37)
                    Hooks.Functions.OnHit(player, hitbox_name, damage)
    
                    return Hooks.Originals.Callbacks.grenadeHitConfirm(player, hitbox_name, v35, damage, v37)
                end)
            end

            do -- Spawn / Despawn hooks
                -- NOTE: For our local playaaaa nigaaaaa
                Hooks.Callbacks.spawn = function(position, viewangles, p35, p36, p37)
                    PlayerInformation.LocalPlayer = {
                        Position = position,
                        ViewAngles = viewangles,
    
                        Alive = true
                    }
    
                    return Hooks.Originals.Callbacks.spawn(position, viewangles, p35, p36, p37)
                end

                -- NOTE: For other jigaboo nigaboo retards who we shoot n shi
                Hooks.Callbacks.newspawn = LPH_NO_UPVALUES(function(player, v56, v57)
                    if GetConfig("Event Logs", "state") and GetConfig("Events To Log", "value", "Spawns") then
                        Libraries.Utilities.Log("Network", player.Name .. " spawned!")
                    end
    
                    return Hooks.Originals.newspawn(player, v56, v57)
                end)
    
                -- NOTE: Tarzan down
                Hooks.Callbacks.died = LPH_NO_UPVALUES(function(player)
                    PlayerInformation.RemovePlayer(player.victim.Name)
    
                    if GetConfig("Event Logs", "state") and GetConfig("Events To Log", "value", "Deaths") then
                        Libraries.Utilities.Log("Network", player.victim.Name .. " died!")
                    end
    
                    if GetConfig("Kill Say", "state") then
                        local Mode, Message = GetConfig("Kill Say Mode", "value")
        
                        if Mode == "Custom" then
                            Message = GetConfig("Kill Say Message", "value")
                        else
                            local MessageList = Cheat.ChatMessages[Mode]
                            
                            Message = MessageList[math.random(0, #MessageList)]
                        end
        
                        Modules.NetworkClient:send("sendChatMessage", Message)
                    end
    
                    return Hooks.Originals.Callbacks.died(player)
                end)
            end

            Hooks.Callbacks.startvotekick = LPH_NO_UPVALUES(function(player_name, time, id)
                if player_name == LocalPlayer.Name and GetConfig("Serverhop On Votekick", "state") then
                    -- TODO: Actually do this, havent cuz im lazy as fuck.
                end

                return Hooks.Originals.Callbacks.startvotekick(player_name, time, id)
            end)

            local TeleportDistance = 3

            Hooks.Callbacks.correctposition = LPH_NO_UPVALUES(function(position)
                --[[local CharacterObject = Modules.CharacterInterface.getCharacterObject()

                if CharacterObject then
                    local RaycastInstance, RaycastIntersection = Services.Workspace:FindPartOnRayWithWhitelist(Ray.new(
                        CharacterObject._rootPart.Position, 
                        Vector3.new(0, -15000, 0)
                    ), {Services.Workspace.Map})

                    if not RaycastInstance or RaycastInstance.Transparency == 1 then
                        return
                    end

                    RaycastIntersection = RaycastIntersection + Vector3.new(0, 2, 0)

                    local DistanceToFloor = (RaycastIntersection - CharacterObject._rootPart.Position).Magnitude

                    local StepCount = math.floor(DistanceToFloor / TeleportDistance)
                    local StepVector = (RaycastIntersection - CharacterObject._rootPart.Position).Unit * TeleportDistance

                    for i = 1, StepCount do
                        CharacterObject._rootPart.Position = CharacterObject._rootPart.Position + StepVector
                        
                        Modules.NetworkClient:send("repupdate", 
                            CharacterObject._rootPart.Position + StepVector,
                            Camera.CFrame.LookVector,
                            Modules.GameClock.getTime()
                        )
                    end
                end]]

                Libraries.Utilities.Log("Server", "Attempted to correct position!")

                return
            end)
        end

        do -- NOTE: ReplicationObject (2)
            Hooks.Originals.ReplicationObject = {
                updateReplication = Modules.ReplicationObject.updateReplication,
                step = Modules.ReplicationObject.step
            }

            Modules.ReplicationObject.updateReplication = function(self, current_frame, clock_time, position, viewangles)
                PlayerInformation.AddPlayer(self, position, viewangles)

                return Hooks.Originals.ReplicationObject.updateReplication(self, current_frame, clock_time, position, viewangles)
            end

            Modules.ReplicationObject.step = function(self, p86, p87)
                Hooks.Originals.ReplicationObject.step(self, p86, p87)

                if GetConfig("Instant Replication", "state") and self._alive then
                    self:resetSprings(self._receivedPosition)
                end
            end
        end

        do -- NOTE: HudSpottingInterface (3)
            Hooks.Originals.isSpotted = Modules.HudSpottingInterface.isSpotted

            Modules.HudSpottingInterface.isSpotted = LPH_NO_UPVALUES(function(player: Instance)
                if GetConfig("Automatic Spotting", "state") then
                    local Entry = Modules.ReplicationInterface.getEntry(player)

                    if not Entry then
                        return
                    end

                    if player ~= LocalPlayer then
                        Entry.isSpotted = true
                    end

                    return Entry.isSpotted
                end

                return Hooks.Originals.isSpotted(player)
            end)
        end

        do -- NOTE: MainCameraObject (4)
            Hooks.Originals.MainCameraObject = {step = Modules.MainCameraObject.step}

            Modules.MainCameraObject.step = LPH_NO_UPVALUES(function(self, dt)
                local CharacterObject = Modules.CharacterInterface.getCharacterObject()

                if CharacterObject then
                    if GetConfig("Remove Suppression", "state") then
                        self._suppressionSpring.p = Vector3.zero
                    end

                    local RemoveBob = GetConfig("Remove Camera Bob", "state")
                    local OriginalSpeed
                    
                    if RemoveBob then
                        OriginalSpeed = CharacterObject._speed
    
                        CharacterObject._speed = 0
                    end

                    local Original = Hooks.Originals.MainCameraObject.step(self, dt)
    
                    if GetConfig("Remove Camera Sway", "state") then
                        self._lookDt = dt
                    end
    
                    if RemoveBob then
                        CharacterObject._speed = OriginalSpeed
                    end

                    return Original
                end

                return Hooks.Originals.MainCameraObject.step(self, dt)
            end)
        end

        do -- NOTE: MeleeObject and FirearmObject (5)
            Hooks.Originals.MeleeObject = {
                step = Modules.MeleeObject.step,
                meleeSway = Modules.MeleeObject.meleeSway,
                walkSway = Modules.MeleeObject.walkSway
            }

            Modules.MeleeObject.step = LPH_NO_UPVALUES(function(self, ...)
                Features.ChamsManager.WeaponStep(self)

                return Hooks.Originals.MeleeObject.step(self, ...)
            end)

            Modules.MeleeObject.meleeSway = LPH_NO_UPVALUES(function(...)
                if GetConfig("Remove Sway", "state") then
                    return CFrame.new()
                end

                return Hooks.Originals.MeleeObject.meleeSway(...)
            end)

            Modules.MeleeObject.walkSway = LPH_NO_UPVALUES(function(...)
                if GetConfig("Remove Sway", "state") then
                    return CFrame.new()
                end

                return Hooks.Originals.MeleeObject.walkSway(...)
            end)

        end

        do -- NOTE: GrenadeObject (6)
            Hooks.Originals.GrenadeObject = {
                objectSway = Modules.MeleeObject.objectSway,
                walkSway = Modules.MeleeObject.walkSway
            }

            Modules.GrenadeObject.objectSway = LPH_NO_UPVALUES(function(...)
                if GetConfig("Remove Sway", "state") then
                    return CFrame.new()
                end

                return Hooks.Originals.GrenadeObject.objectSway(...)
            end)

            Modules.GrenadeObject.walkSway = LPH_NO_UPVALUES(function(...)
                if GetConfig("Remove Sway", "state") then
                    return CFrame.new()
                end

                return Hooks.Originals.GrenadeObject.walkSway(...)
            end)
        end

        do -- NOTE: FirearmObject (7)
            Hooks.Originals.FirearmObject = {
                computeGunSway = Modules.FirearmObject.computeGunSway,
                computeWalkSway = Modules.FirearmObject.computeWalkSway,
                getWeaponStat = Modules.FirearmObject.getWeaponStat,
                step = Modules.FirearmObject.step
            }

            Modules.FirearmObject.computeGunSway = LPH_NO_UPVALUES(function(...)
                if GetConfig("Remove Sway", "state") then
                    return CFrame.new()
                end

                return Hooks.Originals.FirearmObject.computeGunSway(...)
            end)

            Modules.FirearmObject.computeWalkSway = LPH_NO_UPVALUES(function(...)
                if GetConfig("Remove Sway", "state") then
                    return CFrame.new()
                end

                return Hooks.Originals.FirearmObject.computeWalkSway(...)
            end)

            Hooks.Storage.AnimationCache = {}

            Modules.FirearmObject.getWeaponStat = LPH_NO_UPVALUES(function(self, stat, ...)
                if stat == "firemodes" and GetConfig("Full Auto", "state") then
                    return {true, 3, 1}
                elseif (stat == "pullout" or stat == "unequiptime" or stat == "equiptime") and GetConfig("Instant Equip", "state") then
                    return 0
                elseif (stat == "hipfirespread" or stat == "spread" or stat == "hipfirespreadrecover") and GetConfig("Remove Spread", "state") then
                    return 0
                elseif stat == "animations" then
                    local Original = Hooks.Originals.FirearmObject.getWeaponStat(self, stat, ...)

                    local ToReload = {
                        [1] = {
                            Animations = {
                                "reload", "tacticalreload", "HOWAreload",
                                "HOWAtacticalreload", "HOWA2tacticalreload", "HOWA3reload",
                                "HOWA2reload", "HOWA3tacticalreload"
                            },

                            State = GetConfig("Instant Reload", "state"),
                        },
                        [2] = {
                            Animations = {
                                "onfire"
                            },

                            State = GetConfig("Remove Fire Animation", "state"),
                        }
                    }

                    for _, data in ToReload do
                        for _, animation_name in data.Animations do
                            local Animation = Original[animation_name]

                            if not Animation then
                                continue
                            end

                            if not Hooks.Storage.AnimationCache[animation_name] then
                                Hooks.Storage.AnimationCache[animation_name] = {
                                    timescale = Animation.timescale,
                                    stdtimescale = Animation.stdtimescale,
                                    resettime = Animation.resettime 
                                }
                            end

                            local OriginalAnimation = Hooks.Storage.AnimationCache[animation_name]

                            if Animation then
                                setreadonly(Animation, false)

                                if data.State then
                                    Animation.timescale = 0
                                    Animation.stdtimescale = 0

                                    if Animation.resettime then 
                                        Animation.resettime = 0
                                    end
                                else
                                    Animation.timescale = OriginalAnimation.timescale
                                    Animation.stdtimescale = OriginalAnimation.stdtimescale
        
                                    if Animation.resettime then 
                                        Animation.resettime = OriginalAnimation.resettime
                                    end
                                end
                            end
                        end
                    end

                    return Original
                end

                return Hooks.Originals.FirearmObject.getWeaponStat(self, stat, ...)
            end)

            Hooks.Originals.FirearmObject._processEquipStateChange = Modules.FirearmObject._processEquipStateChange
        
            Modules.FirearmObject._processEquipStateChange = LPH_NO_UPVALUES(function(self, _, equipping_state, _)
                Features.ChamsManager.WeaponStep(self)

                return Hooks.Originals.FirearmObject._processEquipStateChange(self, _, equipping_state, _)
            end)

            Modules.FirearmObject.step = LPH_NO_UPVALUES(function(self, v347)
                if GetConfig("Automatic Reload", "state") then
                    local Mode = GetConfig("Automatic Reload Mode", "value")

                    if Mode == "Empty" and self._magCount < 1 then
                        self:reload()
                    elseif Mode == "Always" and self._magCount < self:getWeaponStat("magsize") + 1 then
                        Reversed.Reload(self)
                    end

                    --print(self._canShoot, self:isReloading(), self:isStateReloading(), self:isReloadingCancelling())
                end

                -- NOTE: Currently this breaks if instant reload is on, why? I have no fucking idea.
                if GetConfig("Remove Reload Animation", "state") and self._characterObject.reloading and self._characterObject.animating then
                    self._characterObject.thread:clear()
                    self._characterObject.animating = false
                    self._characterObject.reloading = false

                    --[[self._characterObject.thread:add(Modules.Animation.reset(
                        self._animData, 0.05, self:getWeaponStat("keepanimvisibility") or self:isBlackScoped()
                    ))

                    self._characterObject.animating = false]]
                end

                local CharacterObject, OldSpeed, OldDistance, OldVelocity

                if GetConfig("Remove Weapon Bob", "state") then
                    CharacterObject = Modules.CharacterInterface.getCharacterObject()

                    if CharacterObject then
                        OldSpeed, OldDistance, OldVelocity = CharacterObject:getWalkValues()

                        CharacterObject._velocity = Vector3.zero
                        CharacterObject._distance = 0
                        CharacterObject._speed = 0
                    end
                end

                Hooks.Originals.FirearmObject.step(self, v347)

                if CharacterObject then
                    CharacterObject._velocity = OldVelocity
                    CharacterObject._distance = OldDistance
                    CharacterObject._speed = OldSpeed
                end
            end)
        end

        do -- NOTE: CharacterInterface (8)
            Hooks.Originals.getTimeTillSpawn = Modules.CharacterInterface.getTimeTillSpawn

            Modules.CharacterInterface.getTimeTillSpawn = LPH_NO_UPVALUES(function(v22)
                if GetConfig("Remove Spawn Delay", "state") then
                    return 0
                end

                return Hooks.Originals.getTimeTillSpawn(v22)
            end)
        end

        do -- NOTE: CharacterObject (9)
            Hooks.Originals.CharacterObject = {
                updateWalkSpeed = Modules.CharacterObject.updateWalkSpeed,
                new = Modules.CharacterObject.new,
                step = Modules.CharacterObject.step
            }

            Modules.CharacterObject.updateWalkSpeed = LPH_NO_UPVALUES(function(self)
                if self._movementMode == "stand" then
                    if GetConfig("Auto Sprint", "state") then
                        self._sprinting = true
                    end
    
                    if GetConfig("Auto Jump", "state") and GetConfig("Auto Jump Key") then
                        self._lastJumpTime = 0
    
                        local AdrenalineMovementConfig, JumpHeight = Modules.CharacterConfig.adrenalineMovementConfig
    
                        if Modules.PlayerSettingsInterface.getValue("togglestaminamovement") then 
                            JumpHeight = AdrenalineMovementConfig.stamina.jumpHeight 
                        else 
                            JumpHeight = AdrenalineMovementConfig.normal.jumpHeight
                        end
    
                        -- NOTE: If we are dead, getActiveWeapon is nil.
                        if self._weaponController and self._weaponController.getActiveWeapon then
                            self:jump(JumpHeight)
                        end
                    end
                end

                if self._sprinting then
                    self._walkspeedspring.t = 1.5 * self._walkSpeedMult * self._baseWalkSpeed
                elseif self._movementMode == "prone" then
                    self._walkspeedspring.t = self._walkSpeedMult * self._baseWalkSpeed / 4
                elseif self._movementMode == "crouch" then
                    self._walkspeedspring.t = self._walkSpeedMult * self._baseWalkSpeed / 2
                elseif self._movementMode == "stand" then
                    self._walkspeedspring.t = self._walkSpeedMult * self._baseWalkSpeed
                end

                local SpeedHack = GetConfig("Speed Hack", "state") and GetConfig("Speed Hack Key")
                local FlyHack = GetConfig("Fly Hack", "state") and GetConfig("Fly Hack Key")

                if SpeedHack and not FlyHack then
                    local LookVector = Camera.CFrame.LookVector

                    local DirectionVectors = {
                        [Enum.KeyCode.W] = Vector3.new(LookVector.X, 0, LookVector.Z),
                        [Enum.KeyCode.A] = Vector3.new(LookVector.Z, 0, -LookVector.X),
                        [Enum.KeyCode.S] = -Vector3.new(LookVector.X, 0, LookVector.Z),
                        [Enum.KeyCode.D] = Vector3.new(-LookVector.Z, 0, LookVector.X)
                    }

                    local Direction = Vector3.zero

                    for Key, Dir in DirectionVectors do
                        if Services.UserInputService:IsKeyDown(Key) then
                            Direction = Direction + Dir
                        end
                    end

                    if Direction.Magnitude > 0 then
                        self._rootPart.Velocity = Direction.Unit * GetConfig("Speed Hack Speed", "value") + Vector3.new(0, self._rootPart.Velocity.Y, 0)
                        self._sprinting = false
                    end
                end

                if FlyHack then
                    local FlySpeed = GetConfig("Fly Hack Speed", "value")
                    local LookVector = Camera.CFrame.LookVector
                    
                    local DirectionVectors = {
                        [Enum.KeyCode.W] = LookVector,
                        [Enum.KeyCode.A] = Vector3.new(LookVector.Z, 0, -LookVector.X),
                        [Enum.KeyCode.S] = -LookVector,
                        [Enum.KeyCode.D] = Vector3.new(-LookVector.Z, 0, LookVector.X),
                        
                        [Enum.KeyCode.LeftControl] = Vector3.new(0, -FlySpeed / 10, 0),
                        [Enum.KeyCode.LeftShift] = Vector3.new(0, -FlySpeed / 10, 0),
                        [Enum.KeyCode.Space] = Vector3.new(0, FlySpeed / 10, 0)
                    }

                    local Direction = Vector3.zero

                    for Key, Dir in DirectionVectors do
                        if Services.UserInputService:IsKeyDown(Key) then
                            Direction = Direction + Dir
                        end
                    end

                    if Direction.Magnitude > 0 then
                        self._rootPart.Velocity = Direction.Unit * FlySpeed
                    else
                        self._rootPart.Velocity = Vector3.zero
                    end
                end
            end)

            Modules.CharacterObject.new = LPH_NO_UPVALUES(function(...)
                local CharacterObject = Hooks.Originals.CharacterObject.new(...)

                Features.ChamsManager.ArmsStep(CharacterObject)

                return CharacterObject
            end)

            Modules.CharacterObject.step = LPH_NO_UPVALUES(function(self, vector)
                local WeaponController = self._weaponController

                if WeaponController then
                    local Weapon = WeaponController:getActiveWeapon()

                    Features.Ragebot.Step(self, Weapon)
                    Features.Misc.Step(self)
                end

                if GetConfig("Field Of View Changer", "state") then
                    self.unaimedfov = Modules.SettingsFieldOfView.defaultValue + GetConfig("Field Of View", "value")
                else
                    self.unaimedfov = Modules.SettingsFieldOfView.defaultValue
                end
                
                Modules.CharacterObject.updateWalkSpeed(self)

                local SwayUpdateOriginal, SprintSprintOriginal

                if GetConfig("Remove Sway", "state") then
                    SwayUpdateOriginal = self.sway.update
                    SprintSprintOriginal = self._sprintspring

                    self.sway.update = function(...) end
                    self._sprintspring.t = 0
                end

                local Original = Hooks.Originals.CharacterObject.step(self, vector)

                if SwayUpdateOriginal then
                    self.sway.update = SwayUpdateOriginal
                    self._sprintspring = SprintSprintOriginal
                end

                return Original
            end)
        end

        do -- NOTE: BulletObject (10)
            Hooks.Originals.BulletObject = {new = Modules.BulletObject.new}

            Modules.BulletObject.new = LPH_NO_UPVALUES(function(bullet_data, ...)
                if Features.Ragebot.ActiveTarget and not GetConfig("Ragebot Automatic Fire", "state") then
                    local FirearmObject = Reversed.GetFirearmObject()

                    if FirearmObject then
                        local Trajectory = Reversed.Trajectory(
                            bullet_data.position, Features.Ragebot.ActiveTarget.Destination,
                            -Modules.PublicSettings.bulletAcceleration,
                            FirearmObject:getWeaponStat("bulletspeed") or 0
                        )

                        bullet_data.velocity = Trajectory
                    end
                end

                return Hooks.Originals.BulletObject.new(bullet_data, ...)
            end)
        end
        
        do -- NOTE: RecoilSprings (11)
            Hooks.Originals.RecoilSprings = {applyImpulse = Modules.RecoilSprings.applyImpulse}

            Modules.RecoilSprings.applyImpulse = LPH_NO_UPVALUES(function(...)
                if GetConfig("Remove Recoil", "state") then
                    return
                end

                return Hooks.Originals.RecoilSprings.applyImpulse(...)
            end)
        end

        do -- NOTE: AudioSystem (12)
            Hooks.Originals.playSound = Modules.AudioSystem.playSound

            Modules.AudioSystem.playSound = LPH_NO_UPVALUES(function(sound_name, p36, p37, volume, p39, p40, p41, p42, p43, p44, p45, p46, p47)
                -- NOTE: Phantom Forces 'hitmarker' is called along with bullethit, if the server invalidates our shot it will still play.
                if sound_name == "hitmarker" and GetConfig("Hit Sound", "state") then
                    return
                end

                --[[if Library.flags["Override Sound Volume"] then
                    if string.find(sound_name, "land") then
                        volume = volume * (Library.flags["Landing Volume"] / 100)
                    elseif string.find(sound_name, "imp_") then
                        volume = volume * (Library.flags["Impact Volume"] / 100)
                    else
                        volume = volume * (Library.flags["Others Volume"] / 100)
                    end
                end]]

                return Hooks.Originals.playSound(sound_name, p36, p37, volume, p39, p40, p41, p42, p43, p44, p45, p46, p47)
            end)
        end

        do -- NOTE: FirearmSight (13)
            Hooks.Originals.FirearmSight = {step = Modules.FirearmSight.step}

            Modules.FirearmSight.step = LPH_NO_UPVALUES(function(self)
                if self._aperturelens and GetConfig("Remove Aperture Lens", "state") then
                    self._aperturelens:Destroy()
                end
 
                return Hooks.Originals.FirearmSight.step(self)
            end)
        end

        do -- NOTE: ThirdPersonObject (14)
            Hooks.Originals.ThirdPersonObject = {
                setCharacterRender = Modules.ThirdPersonObject.setCharacterRender
            }

            Modules.ThirdPersonObject.setCharacterRender = LPH_NO_UPVALUES(function(self, state)
                if self._player.Team ~= LocalPlayer.Team then
                    local CharacterModel = self:getCharacterModel()

                    if CharacterModel and state then
                        CharacterModel.Parent = Features.Highlights.PlayersFolder
                    end

                    return
                end

                return Hooks.Originals.ThirdPersonObject.setCharacterRender(self, state)
            end)
        end

        do -- NOTE: Effects (15)
            Hooks.Originals.setuplighting = Modules.Effects.setuplighting

            Modules.Effects.setuplighting = LPH_NO_UPVALUES(function(...)
                local Original = Hooks.Originals.setuplighting(...)

                Features.Lighting.SetupLighting()

                return Original
            end)
        end

        do -- NOTE: HudScopeInterface (16)
            local ScreenGui = Modules.UnscaledScreenGui.getScreenGui()
            local ScopeFrontLayer = ScreenGui.DisplayScope.ImageFrontLayer
            local ScopeRearLayer = ScreenGui.DisplayScope.ImageRearLayer

            local SetVisibility = function(state)
                for i = 1, 2 do
                    local layer = i == 1 and ScopeFrontLayer or ScopeRearLayer
    
                    for _, frame in layer:GetChildren() do
                        if frame.ClassName ~= "Frame" then
                            continue
                        end

                        frame.Visible = state
                    end
                end
            end

            Hooks.Originals.updateScope = Modules.HudScopeInterface.updateScope

            Modules.HudScopeInterface.updateScope = LPH_NO_UPVALUES(function(...)
                if GetConfig("Remove Scope", "state") then
                    ScopeFrontLayer.ImageTransparency = 1
                    ScopeRearLayer.ImageTransparency = 1
        
                    SetVisibility(false)
                else
                    ScopeFrontLayer.ImageTransparency = 0
                    ScopeRearLayer.ImageTransparency = 0
                    
                    SetVisibility(true)
                end

                return Hooks.Originals.updateScope(...)
            end)
        end

        do -- NOTE: Namecall (17)
            Hooks.Originals.Namecall = hookmetamethod(game, "__namecall", LPH_NO_VIRTUALIZE(function(self, ...)
                local Arguments = {...}
            
                if getnamecallmethod() == "FireServer" and Arguments[1] == "\n" then
                    return
                end
            
                return Hooks.Originals.Namecall(self, ...)
            end))
        end

        Hooks.Unload = function()
            Modules.NetworkClient.send = Hooks.Originals.NetworkClient.send

            Hooks.Callbacks.newbullets = Hooks.Originals.Callbacks.newbullets
            Hooks.Callbacks.bulletHitConfirm = Hooks.Originals.Callbacks.bulletHitConfirm
            Hooks.Callbacks.meleeHitConfirm = Hooks.Originals.Callbacks.meleeHitConfirm
            Hooks.Callbacks.grenadeHitConfirm = Hooks.Originals.Callbacks.grenadeHitConfirm
            Hooks.Callbacks.newspawn = Hooks.Originals.Callbacks.newspawn
            Hooks.Callbacks.died = Hooks.Originals.Callbacks.died
            Hooks.Callbacks.startvotekick = Hooks.Originals.Callbacks.startvotekick
            Hooks.Callbacks.correctposition = Hooks.Originals.Callbacks.correctposition
            Hooks.Callbacks.spawn = Hooks.Originals.Callbacks.spawn

            Modules.ReplicationInterface.ReplicationObject.updateReplication = Hooks.Originals.ReplicationObject.updateReplication
            Modules.ReplicationInterface.ReplicationObject.step = Hooks.Originals.ReplicationObject.step

            Modules.HudSpottingInterface.isSpotted = Hooks.Originals.isSpotted

            Modules.MainCameraObject.step = Hooks.Originals.MainCameraObject.step

            Modules.MeleeObject.meleeSway = Hooks.Originals.MeleeObject.meleeSway
            Modules.MeleeObject.walkSway = Hooks.Originals.MeleeObject.walkSway

            Modules.GrenadeObject.objectSway = Hooks.Originals.GrenadeObject.objectSway
            Modules.GrenadeObject.walkSway = Hooks.Originals.GrenadeObject.walkSway

            Modules.FirearmObject.computeGunSway = Hooks.Originals.FirearmObject.computeGunSway
            Modules.FirearmObject.computeWalkSway = Hooks.Originals.FirearmObject.computeWalkSway
            Modules.FirearmObject.getWeaponStat = Hooks.Originals.FirearmObject.getWeaponStat
            Modules.FirearmObject.step = Hooks.Originals.FirearmObject.step

            Modules.CharacterInterface.getTimeTillSpawn = Hooks.Originals.getTimeTillSpawn

            Modules.CharacterObject.updateWalkSpeed = Hooks.Originals.CharacterObject.updateWalkSpeed
            Modules.CharacterObject.new = Hooks.Originals.CharacterObject.new
            Modules.CharacterObject.step = Hooks.Originals.CharacterObject.step

            Modules.BulletObject.new = Hooks.Originals.BulletObject.new

            Modules.RecoilSprings.applyImpulse = Hooks.Originals.RecoilSprings.applyImpulse

            Modules.AudioSystem.playSound = Hooks.Originals.playSound

            Modules.FirearmSight.step = Hooks.Originals.FirearmSight.step

            Modules.ThirdPersonObject.setCharacterRender = Hooks.Originals.ThirdPersonObject.setCharacterRender

            Modules.Effects.setuplighting = Hooks.Originals.setuplighting
            
            Modules.HudScopeInterface.updateScope = Hooks.Originals.updateScope

            hookmetamethod(game, "__namecall", Hooks.Originals.Namecall)
        end
    end

    do -- NOTE: UI Initiation
        Libraries.Interface.Warning = Libraries.Interface:AddWarning({type = "confirm"})

        Libraries.Interface.title = Cheat.Emoji .. " " .. Cheat.Name
        Libraries.Interface.status = Cheat.Username .. " / " .. Cheat.Build

        Libraries.Interface.foldername = Cheat.Directory .. "/Configs"

        local Tabs, Columns, Sections

        do -- Setup Tabs, Columns, and Sections
            Tabs = {
                --Legitbot = Libraries.Interface:AddTab("Legitbot"),
                Ragebot = Libraries.Interface:AddTab("Ragebot"),
                --Antiaim = Libraries.Interface:AddTab("Anti-aim"),
                Visuals = Libraries.Interface:AddTab("Visuals"),
                Misc = Libraries.Interface:AddTab("Misc"),
                Config = Libraries.Interface:AddTab("Config")
            }
        
            Columns = {
                --[[Legitbot = {
                    Left = Tabs.Legitbot:AddColumn(),
                    Middle = Tabs.Legitbot:AddColumn(),
                    Right = Tabs.Legitbot:AddColumn()
                },]]
        
                Ragebot = {
                    Left = Tabs.Ragebot:AddColumn(),
                    Middle = Tabs.Ragebot:AddColumn(),
                    Right = Tabs.Ragebot:AddColumn()
                },
        
                --[[Antiaim = {
                    Left = Tabs.Antiaim:AddColumn()
                },]]
        
                Visuals = {
                    Left = Tabs.Visuals:AddColumn(),
                    Middle = Tabs.Visuals:AddColumn(),
                    Right = Tabs.Visuals:AddColumn()
                },
        
                Misc = {
                    Left = Tabs.Misc:AddColumn(),
                    Middle = Tabs.Misc:AddColumn(),
                    Right = Tabs.Misc:AddColumn()
                },
        
                Config = {
                    Left = Tabs.Config:AddColumn(),
                    Middle = Tabs.Config:AddColumn(),
                    Right = Tabs.Config:AddColumn()
                }
            }
        
            Sections = {
                --[[Legitbot = {
                    General = Columns.Legitbot.Left:AddSection("General"),

                },]]
        
                Ragebot = {
                    General = Columns.Ragebot.Left:AddSection("General"),
                    Exploits = Columns.Ragebot.Middle:AddSection("Exploits"),

                    -- NOTE: this is not really a `Knife bot` so Well call it `Knife aura`
                    KnifeBot = Columns.Ragebot.Middle:AddSection("Knife aura"),

                    Other = Columns.Ragebot.Right:AddSection("Other"),
                    Debug = Columns.Ragebot.Right:AddSection("Debug", true)
                },
        
                --[[Antiaim = {
                    General = Columns.Antiaim.Left:AddSection("General")
                },]]
        
                Visuals = {
                    Enemy = Columns.Visuals.Left:AddSection("Enemy ESP"),
                    EnemyChams = Columns.Visuals.Left:AddSection("Enemy chams"),
                    LocalPlayer = Columns.Visuals.Middle:AddSection("Local player"),
                    Lighting = Columns.Visuals.Middle:AddSection("Lighting"),
                    World = Columns.Visuals.Right:AddSection("World"),
                    Other = Columns.Visuals.Right:AddSection("Other")
                },
        
                Misc = {
                    General = Columns.Misc.Left:AddSection("General"),
                    Camera = Columns.Misc.Left:AddSection("Camera"),
                    WeaponMods = Columns.Misc.Left:AddSection("Weapon modification"),
                    Movement = Columns.Misc.Middle:AddSection("Movement"),
                    Sounds = Columns.Misc.Middle:AddSection("Sounds"),
                    EventLogs = Columns.Misc.Middle:AddSection("Event logs"),
                    Other = Columns.Misc.Right:AddSection("Other"),
                    Fun = Columns.Misc.Right:AddSection("Fun")
                },
        
                Config = {
                    Settings = Columns.Config.Left:AddSection("Settings"),
                    Theme = Columns.Config.Middle:AddSection("Theme"),
                    Configuration = Columns.Config.Right:AddSection("Configuration")
                }
            }
        end

        do -- Layout
            do -- Ragebot
                do -- General
                    Sections.Ragebot.General:AddToggle({
                        text = "Enabled", 
                        flag = "Ragebot Enabled"
                    })

                    Sections.Ragebot.General:AddToggle({
                        text = "Automatic fire", 
                        flag = "Ragebot Automatic Fire"
                    })

                    Sections.Ragebot.General:AddToggle({
                        text = "Automatic penetration", 
                        flag = "Ragebot Automatic Penetration"
                    })

                    Sections.Ragebot.General:AddToggle({
                        text = "Limit field of view", 
                        flag = "Ragebot Limit Fov"
                    }):AddSlider({
                        flag = "Ragebot Maximum Fov",

                        min = 0, max = 180, value = 180,
                        suffix = "\u{00B0}" -- °: Degree symbol
                    })

                    Sections.Ragebot.General:AddToggle({
                        text = "Limit targets per tick", 
                        flag = "Ragebot Limit Targets Per Tick",
                        state = true
                    }):AddSlider({
                        flag = "Ragebot Limit Targets Per Tick Amount",

                        min = 1, max = 16, value = 4
                    })

                    Sections.Ragebot.General:AddSlider({
                        text = "Bulletcheck time step", 
                        flag = "Ragebot BulletCheck Time Step",

                        min = 10, max = 60, value = 30
                    })

                    Sections.Ragebot.General:AddSlider({
                        text = "Maximum penetrations", 
                        flag = "Ragebot Maximum Penetrations",

                        min = 1, max = 50, value = 25
                    })

                    Sections.Ragebot.General:AddToggle({
                        text = "Limit distance", 
                        flag = "Ragebot Limit Distance"
                    }):AddSlider({
                        flag = "Ragebot Maximum Distance",

                        min = 0, max = 10000, value = 2500,
                        suffix = "st"
                    })

                    Sections.Ragebot.General:AddList({
                        text = "Sorting mode", 
                        flag = "Ragebot Sorting Mode", 
                        values = {"Health", "Distance"},
                        value = "Distance",
                        max = 8
                    })

                    Sections.Ragebot.General:AddToggle({
                        text = "Minimum damage", 
                        flag = "Ragebot Limit Damage"
                    }):AddSlider({
                        flag = "Ragebot Minimum Damage",

                        min = 0, max = 120, value = 100, 
                        suffix = "dmg"
                    })

                    Sections.Ragebot.General:AddToggle({
                        text = "Scale off health",
                        flag = "Ragebot Scale Damage",
                        state = true,

                        tip = "If the target's health < x, x = target health."
                    })
                end

                do -- Exploits
                    Sections.Ragebot.Exploits:AddToggle({
                        text = "Instant hit", 
                        flag = "Ragebot Instant Hit",
                        tip = "Detected, this feature is intended for Hack Vs Hack.",
                        warning = true
                    })

                    Sections.Ragebot.Exploits:AddToggle({
                        text = "Fire position scanning", 
                        flag = "Ragebot Fire Position Scanning"
                    }):AddSlider({
                        flag = "Ragebot Fire Position Scanning Distance", 
                        min = 0, max = 15, value = 10,
                        suffix = "st" -- NOTE: Studs
                    })
    
                    Sections.Ragebot.Exploits:AddToggle({
                        text = "Randomize distance",
                        flag = "Ragebot Fire Position Scanning Randomization"
                    })

                    Sections.Ragebot.Exploits:AddToggle({
                        text = "Target position scanning", 
                        flag = "Ragebot Target Scanning"
                    }):AddSlider({
                        flag = "Ragebot Target Scanning Distance", 
                        min = 0, max = 12, value = 8,
                        suffix = "st" -- NOTE: Studs
                    })
    
                    Sections.Ragebot.Exploits:AddToggle({
                        text = "Randomize distance",
                        flag = "Ragebot Target Scanning Randomization"
                    })
                end

                do -- Knife bot
                    Sections.Ragebot.KnifeBot:AddToggle({
                        text = "Enabled", 
                        flag = "Ragebot Knife Bot",
                        state = true
                    })

                    Sections.Ragebot.KnifeBot:AddToggle({
                        text = "Visible only", 
                        flag = "Ragebot Knife Bot Visible only"
                    })

                    -- TODO: Add teleport scanning if value > 25st
                    -- NOTE: You should be able to teleport 60-70st (just like normal teleport scanning)
                    Sections.Ragebot.KnifeBot:AddSlider({
                        text = "Distance", 
                        flag = "Ragebot Knife Bot Distance",

                        min = 0, max = 25, value = 25,
                        suffix = "st" -- NOTE: Studs
                    })
                end

                do -- Other
                    Sections.Ragebot.Other:AddToggle({
                        text = "Performance mode", 
                        flag = "Ragebot Performance Mode"
                    })
                end

                if Developer then -- Debug
                    Sections.Ragebot.Debug:AddToggle({
                        text = "Suppress shots", 
                        flag = "Ragebot Suppress Shots",
                    })

                    Sections.Ragebot.Debug:AddToggle({
                        text = "Visualize fire scan", 
                        flag = "Ragebot Visualize Fire Positions"
                    })

                    Sections.Ragebot.Debug:AddToggle({
                        text = "Visualize target scan", 
                        flag = "Ragebot Visualize Target Positions"
                    })
                end
            end

            do -- Anti-aim
                
            end

            do -- Visuals
                do -- Enemy
                    Sections.Visuals.Enemy:AddToggle({
                        text = "Enabled", 
                        flag = "ESP Enabled"
                    })

                    Sections.Visuals.Enemy:AddToggle({
                        text = "Visible only", 
                        flag = "ESP Visible Only",

                        callback = function(state)
                            Features.Highlights.PlayersHighlight.DepthMode = state 
                                and Enum.HighlightDepthMode.Occluded or Enum.HighlightDepthMode.AlwaysOnTop
                        end
                    })

                    Sections.Visuals.Enemy:AddToggle({
                        text = "Show teammates", 
                        flag = "ESP Show Teammates"
                    })
        
                    Sections.Visuals.Enemy:AddToggle({
                        text = "Name",
                        flag = "ESP Player Name",

                        callback = function(state)
                            Features.Esp.UpdateInstance({"Name"}, {
                                Visible = state
                            })
                        end
                    }):AddColor({
                        flag = "ESP Player Name Color",
                        color = Color3.fromRGB(255, 255, 255),
                        trans = 255,

                        callback = function(color, transparency)
                            Features.Esp.UpdateInstance({"Name"}, {
                                TextColor3 = color,
                                TextStrokeTransparency = 1 - transparency
                            })
                        end
                    })
        
                    Sections.Visuals.Enemy:AddToggle({
                        text = "Weapon",
                        flag = "ESP Player Weapon",

                        callback = function(state)
                            Features.Esp.UpdateInstance({"Weapon"}, {
                                Visible = state
                            })
                        end
                    }):AddColor({
                        flag = "ESP Player Weapon Color",
                        color = Color3.fromRGB(255, 160, 60),
                        trans = 255,

                        callback = function(color, transparency)
                            Features.Esp.UpdateInstance({"Weapon"}, {
                                TextColor3 = color,
                                TextStrokeTransparency = 1 - transparency
                            })
                        end
                    })
        
                    Sections.Visuals.Enemy:AddToggle({ 
                        text = "Box", 
                        flag = "ESP Player Box",
                        
                        callback = function(state)
                            Features.Esp.UpdateInstance({"Box", "BoxInner", "BoxOuter"}, {
                                Enabled = state
                            })

                            Features.Esp.UpdateInstance({"Frame"}, {
                                BackgroundTransparency = (state and GetConfig("ESP Player Box Fill", "state")) and (1 - GetConfig("ESP Player Box Fill Color", "trans")) or 1
                            })
                        end
                    }):AddColor({ 
                        flag = "ESP Player Box Color", 
                        color = Color3.fromRGB(255, 255, 255), 
                        trans = 255,

                        callback = function(color, transparency)
                            Features.Esp.UpdateInstance({"Box"}, {
                                Color = color,
                                Transparency = 1 - transparency
                            })

                            Features.Esp.UpdateInstance({"BoxInner", "BoxOuter"}, {
                                Transparency = 1 - transparency
                            })
                        end
                    })
                    
                    Sections.Visuals.Enemy:AddToggle({ 
                        text = "Box fill", 
                        flag = "ESP Player Box Fill",

                        callback = function(state)
                            local State = state and GetConfig("ESP Player Box", "state")

                            Features.Esp.UpdateInstance({"Frame"}, {
                                BackgroundTransparency = State and (1 - GetConfig("ESP Player Box Fill Color", "trans")) or 1
                            })
                        end
                    }):AddColor({ 
                        flag = "ESP Player Box Fill Color", 
                        color = Color3.fromRGB(0, 0, 0), 
                        trans = 255,

                        callback = function(color, transparency)
                            local State = GetConfig("ESP Player Box", "state") and GetConfig("ESP Player Box Fill", "state")

                            Features.Esp.UpdateInstance({"Frame"}, {
                                BackgroundColor3 = color,
                                BackgroundTransparency = State and (1 - transparency) or 1
                            })
                        end
                    })
                    
                    Sections.Visuals.Enemy:AddToggle({ 
                        text = "Health bar", 
                        flag = "ESP Player Health",

                        callback = function(state)
                            Features.Esp.UpdateInstance({"HealthBackground", "HealthFrame"}, {
                                Visible = state
                            })
                        end
                    }):AddColor({ 
                        flag = "ESP Player Health Color", 
                        color = Color3.fromRGB(150, 0, 0),
                        trans = 255
                    }):AddColor({ 
                        flag = "ESP Player Health Full Color", 
                        color = Color3.fromRGB(160, 200, 40), 
                        trans = 255
                    })
                    
                    Sections.Visuals.Enemy:AddToggle({ 
                        text = "Health number", 
                        flag = "ESP Player Health Number",

                        callback = function(state)
                            Features.Esp.UpdateInstance({"HealthNumber"}, {
                                Visible = state
                            })
                        end
                    }):AddColor({ 
                        flag = "ESP Player Health Number Color", 
                        color = Color3.fromRGB(255, 255, 255), 
                        trans = 255,

                        callback = function(color, transparency)
                            Features.Esp.UpdateInstance({"HealthNumber"}, {
                                TextColor3 = color,
                                TextStrokeTransparency = 1 - transparency
                            })
                        end
                    })

                    -- TODO
                    Sections.Visuals.Enemy:AddList({
                        text = "Flags", 
                        flag = "ESP Player Flags",
                        values = {"Knife", "Distance", "Rank"},
                        value = "default",
                        multiselect = true,
                        max = 8
                    })
        
                    Sections.Visuals.Enemy:AddToggle({ 
                        text = "Limit distance", 
                        flag = "ESP Limit Distance"
                    }):AddSlider({ 
                        flag = "ESP Distance Limit", 
                        min = 0, 
                        max = 2500, 
                        value = 2500, 
                        suffix = "st" 
                    })

                    Sections.Visuals.Enemy:AddToggle({
                        text = "Follow server position", 
                        flag = "ESP Follow Server Position"
                    })

                    --[[Sections.Visuals.Other:AddToggle({ 
                        text = "Highlight target", 
                        flag = "ESP Highlight Target"
                    }):AddColor({ 
                        flag = "ESP Highlight Target Color", 
                        color = Color3.fromRGB(255, 0, 0), 
                        trans = 255
                    })]]
                end

                do -- Enemy chams
                    Sections.Visuals.EnemyChams:AddToggle({ 
                        text = "Highlight", 
                        flag = "Highlight Players",

                        callback = function(state)
                            Features.Highlights.PlayersHighlight.Enabled = state
                        end
                    }):AddColor({ 
                        flag = "Player Highlight Fill Color", 
                        color = Color3.fromRGB(200, 130, 60), 
                        trans = 255,

                        callback = function(color, transparency)
                            Features.Highlights.PlayersHighlight.FillColor = color
                            Features.Highlights.PlayersHighlight.FillTransparency = 1 - transparency
                        end
                    }):AddColor({
                        flag = "Player Highlight Outline Color", 
                        color = Color3.fromRGB(255, 160, 60), 
                        trans = 255,

                        callback = function(color, transparency)
                            Features.Highlights.PlayersHighlight.OutlineColor = color
                            Features.Highlights.PlayersHighlight.OutlineTransparency = 1 - transparency
                        end
                    })
                end
        
                do -- Localplayer
                    Sections.Visuals.LocalPlayer:AddToggle({ 
                        text = "Arm chams", 
                        flag = "Arm Chams",

                        callback = function()
                            Features.ChamsManager.ArmsStep()
                        end
                    }):AddColor({ 
                        flag = "Arm Chams Color", 
                        color = Color3.fromRGB(255, 160, 60), 
                        trans = 255,

                        callback = function()
                            Features.ChamsManager.ArmsStep()
                        end
                    })

                    Sections.Visuals.LocalPlayer:AddToggle({ 
                        text = "Highlight", 
                        flag = "Highlight Arms",

                        callback = function(state)
                            Features.Highlights.ArmsHighlight.Enabled = state
                        end
                    }):AddColor({ 
                        flag = "Arms Highlight Fill Color", 
                        color = Color3.fromRGB(200, 130, 60), 
                        trans = 255,

                        callback = function(color, transparency)
                            Features.Highlights.ArmsHighlight.FillColor = color
                            Features.Highlights.ArmsHighlight.FillTransparency = 1 - transparency
                        end
                    }):AddColor({
                        flag = "Arms Highlight Outline Color", 
                        color = Color3.fromRGB(255, 160, 60), 
                        trans = 255,

                        callback = function(color, transparency)
                            Features.Highlights.ArmsHighlight.OutlineColor = color
                            Features.Highlights.ArmsHighlight.OutlineTransparency = 1 - transparency
                        end
                    })
                    
                    Sections.Visuals.LocalPlayer:AddList({ 
                        text = "Material", 
                        flag = "Arm Chams Material", 
                        values = Libraries.Utilities.GetKeysFromTable(Cheat.Materials), 
                        value = "ForceField", 
                        max = 8,

                        callback = function()
                            Features.ChamsManager.ArmsStep()
                        end
                    })

                    Sections.Visuals.LocalPlayer:AddList({ 
                        text = "Texture", 
                        flag = "Arm Chams Texture", 
                        values = Libraries.Utilities.GetKeysFromTable(Cheat.Textures, "Off"), 
                        value = "Off", 
                        max = 8,

                        callback = function()
                            Features.ChamsManager.ArmsStep()
                        end
                    })
                    
                    Sections.Visuals.LocalPlayer:AddToggle({ 
                        text = "Weapon chams", 
                        flag = "Weapon Chams",

                        callback = function()
                            Features.ChamsManager.WeaponStep()
                        end
                    }):AddColor({ 
                        flag = "Weapon Chams Color", 
                        color = Color3.fromRGB(255, 160, 60), 
                        trans = 255,

                        callback = function()
                            Features.ChamsManager.WeaponStep()
                        end
                    })

                    Sections.Visuals.LocalPlayer:AddToggle({ 
                        text = "Highlight", 
                        flag = "Highlight Weapon",

                        callback = function(state)
                            Features.Highlights.WeaponHighlight.Enabled = state
                        end
                    }):AddColor({ 
                        flag = "Weapon Highlight Fill Color", 
                        color = Color3.fromRGB(200, 130, 60), 
                        trans = 255,

                        callback = function(color, transparency)
                            Features.Highlights.WeaponHighlight.FillColor = color
                            Features.Highlights.WeaponHighlight.FillTransparency = 1 - transparency
                        end
                    }):AddColor({
                        flag = "Weapon Highlight Outline Color", 
                        color = Color3.fromRGB(255, 160, 60), 
                        trans = 255,

                        callback = function(color, transparency)
                            Features.Highlights.WeaponHighlight.OutlineColor = color
                            Features.Highlights.WeaponHighlight.OutlineTransparency = 1 - transparency
                        end
                    })
                    
                    Sections.Visuals.LocalPlayer:AddList({ 
                        text = "Material", 
                        flag = "Weapon Chams Material", 
                        values = Libraries.Utilities.GetKeysFromTable(Cheat.Materials), 
                        value = "ForceField", 
                        max = 8,

                        callback = function()
                            Features.ChamsManager.WeaponStep()
                        end
                    })

                    Sections.Visuals.LocalPlayer:AddList({ 
                        text = "Texture", 
                        flag = "Weapon Chams Texture", 
                        values = Libraries.Utilities.GetKeysFromTable(Cheat.Textures, "Off"), 
                        value = "Off", 
                        max = 8,

                        callback = function()
                            Features.ChamsManager.WeaponStep()
                        end
                    })
        
                    -- TODO: Add LocalPlayer Chams.
                end

                do -- Lighting
                    Sections.Visuals.Lighting:AddList({ 
                        text = "Technology", 
                        flag = "Technology", 
                        values = {"Compatibility", "Future", "Legacy", "ShadowMap", "Voxel"}, 
                        value = "ShadowMap", 
                        max = 8,

                        callback = function(value)
                            Services.Lighting.Technology = value
                        end
                    })

                    Sections.Visuals.Lighting:AddToggle({ 
                        text = "Override clock time", 
                        flag = "Override Clock Time"
                    }):AddSlider({ 
                        flag = "Clock Time", 
                        min = 0,  max = 24, value = 12, 
                        suffix = "h",

                        callback = function(value)
                            if not GetConfig("Override Clock Time", "state") then
                                return
                            end

                            Services.Lighting.ClockTime = value
                        end
                    })
    
                    Sections.Visuals.Lighting:AddToggle({ 
                        text = "Override sun brightness", 
                        flag = "Override Sun Brightness"
                    }):AddSlider({ 
                        flag = "Sun Brightness",
                        min = 0, max = 100, 
                        value = Services.Lighting.Brightness * 100, 
                        suffix = "%" ,

                        callback = function(value)
                            if not GetConfig("Override Sun Brightness", "state") then
                                return
                            end

                            Services.Lighting.Brightness = value / 100
                        end
                    })

                    Sections.Visuals.Lighting:AddToggle({ 
                        text = "Bloom", 

                        callback = function()
                            Features.Lighting.OverrideBloom()
                        end
                    })

                    Sections.Visuals.Lighting:AddSlider({
                        text = "Intensity",
                        flag = "Bloom Intensity",
                        min = 0, max = 20, 
                        value = 1,

                        callback = function()
                            Features.Lighting.OverrideBloom()
                        end
                    })

                    Sections.Visuals.Lighting:AddSlider({ 
                        text = "Threshold",
                        flag = "Bloom Threshold",
                        min = 0, max = 1, 
                        value = 0.8,
                        float = 0.1, 

                        callback = function()
                            Features.Lighting.OverrideBloom()
                        end
                    })

                    Sections.Visuals.Lighting:AddSlider({ 
                        text = "Size",
                        flag = "Bloom Size",
                        min = 0, max = 100, 
                        value = 50, 

                        callback = function()
                            Features.Lighting.OverrideBloom()
                        end
                    })
                end

                do -- World
                    Sections.Visuals.World:AddToggle({ 
                        text = "Ambient lighting", 
                        flag = "Ambient Lighting",

                        callback = function()
                            Features.Lighting.OverrideAmbients()
                        end
                    }):AddColor({ 
                        flag = "Ambient Lighting Color", 
                        color = Color3.fromRGB(30, 30, 30),

                        callback = function()
                            Features.Lighting.OverrideAmbients()
                        end
                    })

                    local DirectLighting = Sections.Visuals.World:AddToggle({ 
                        text = "Direct lighting", 
                        flag = "Direct Lighting",

                        callback = function()
                            Features.Lighting.OverrideDLights()
                        end
                    }):AddColor({ 
                        flag = "Direct Lighting Color", 
                        color = Color3.fromRGB(30, 30, 30),

                        callback = function()
                            Features.Lighting.OverrideDLights()
                        end
                    })

                    DirectLighting.AddSlider({ 
                        text = "Range", 
                        flag = "Direct Lighting Range", 
                        min = 0,  max = 100, value = 20,
                        suffix = "m"
                    })
    
                    DirectLighting.AddSlider({ 
                        text = "Brightness", 
                        flag = "Direct Lighting Brightness", 
                        min = 0,  max = 10, value = 1
                    })

                    Sections.Visuals.World:AddToggle({ 
                        text = "Override skybox", 
                        flag = "Skybox Changer",

                        callback = function()
                            Features.Lighting.OverrideSkybox()
                        end
                    }):AddList({ 
                        text = "Skybox", 
                        flag = "Skybox", 
                        values = Libraries.Utilities.GetKeysFromTable(Cheat.Skyboxes), 
                        value = "Pink Daylight", 
                        max = 8,

                        callback = function()
                            Features.Lighting.OverrideSkybox()
                        end
                    })

                    Sections.Visuals.World:AddToggle({ 
                        text = "Show celestial bodies", 
                        flag = "Celestial Bodies",
                        tip = "Toggles visibility of the sun, moon, and stars in the skybox",
                        
                        callback = function()
                            Features.Lighting.OverrideSkybox()
                        end
                    })

                    Sections.Visuals.World:AddToggle({
                        text = "Local bullet tracers", 
                        flag = "Local Bullet Tracers",
                    }):AddColor({
                        flag = "Local Bullet Tracers Color",
                        color = Color3.fromRGB(255, 255, 255)
                    })

                    Sections.Visuals.World:AddToggle({
                        text = "Enemy bullet tracers", 
                        flag = "Enemy Bullet Tracers",
                    }):AddColor({
                        flag = "Enemy Bullet Tracers Color",
                        color = Color3.fromRGB(255, 255, 255)
                    })

                    Sections.Visuals.World:AddList({ 
                        text = "Texture",
                        flag = "Bullet Tracers Texture",
                        values = Libraries.Utilities.GetKeysFromTable(Cheat.Tracers),
                        value = "Default",
                        max = 8
                    })

                    Sections.Visuals.World:AddSlider({ 
                        text = "Texture speed",
                        flag = "Bullet Tracers Texture Speed",
                        min = 0, max = 20, value = 8
                    })
                    
                    Sections.Visuals.World:AddSlider({ 
                        text = "Time",
                        flag = "Bullet Tracers Time",
                        min = 0,  max = 10, value = 3,
                        suffix = "s"
                    })
                end

                do -- Other
                    Sections.Visuals.Other:AddToggle({ 
                        text = "Field of view changer", 
                        flag = "Field Of View Changer"
                    }):AddSlider({ 
                        flag = "Field Of View",
                        min = -40, max = 30, value = 0
                    })
                end
            end

            do -- Misc
                do -- General
                    Sections.Misc.General:AddToggle({
                        text = "Remove spawn delay",
                        flag = "Remove Spawn Delay"
                    })

                    Sections.Misc.General:AddToggle({
                        text = "Remove fall damage",
                        flag = "Remove Fall Damage"
                    })
                    
                    Sections.Misc.General:AddToggle({
                        text = "Automatic spotting",
                        flag = "Automatic Spotting"
                    })

                    Sections.Misc.General:AddToggle({
                        text = "Automatic deploy",
                        flag = "Auto Deploy"
                    })

                    Sections.Misc.General:AddToggle({
                        text = "Instant replication",
                        flag = "Instant Replication"
                    })

                    --[[Sections.Misc.General:AddToggle({
                        text = "Unlock all knifes",
                        flag = "Unlock All Knifes"
                    })

                    Sections.Misc.General:AddToggle({
                        text = "Unlock all attachments",
                        flag = "Unlock All Attachments"
                    })]]
                end

                do -- Camera
                    Sections.Misc.Camera:AddToggle({
                        text = "Remove aperture lens",
                        flag = "Remove Aperture Lens"
                    })

                    Sections.Misc.Camera:AddToggle({
                        text = "Remove suppression",
                        flag = "Remove Suppression"
                    })

                    Sections.Misc.Camera:AddToggle({
                        text = "Remove sway",
                        flag = "Remove Camera Sway"
                    })

                    Sections.Misc.Camera:AddToggle({
                        text = "Remove bob",
                        flag = "Remove Camera Bob"
                    })
                end

                do -- Weapon modifications
                    Sections.Misc.WeaponMods:AddToggle({
                        text = "Remove reload animation",
                        flag = "Remove Reload Animation"
                    })

                    Sections.Misc.WeaponMods:AddToggle({
                        text = "Remove fire animation",
                        flag = "Remove Fire Animation"
                    })

                    Sections.Misc.WeaponMods:AddToggle({
                        text = "Automatic reload",
                        flag = "Automatic Reload"
                    }):AddList({
                        flag = "Automatic Reload Mode",

                        values = {"Empty", "Always"},
                        value = "Empty",
                        max = 8
                    })

                    Sections.Misc.WeaponMods:AddToggle({ 
                        text = "Instant reload", 
                        flag = "Instant Reload"
                    })
    
                    Sections.Misc.WeaponMods:AddToggle({ 
                        text = "Instant equip", 
                        flag = "Instant Equip"
                    })

                    Sections.Misc.WeaponMods:AddToggle({
                        text = "Remove recoil",
                        flag = "Remove Recoil"
                    })

                    Sections.Misc.WeaponMods:AddToggle({
                        text = "Remove spread",
                        flag = "Remove Spread"
                    })

                    Sections.Misc.WeaponMods:AddToggle({
                        text = "Remove sway",
                        flag = "Remove Sway"
                    })

                    Sections.Misc.WeaponMods:AddToggle({
                        text = "Remove bob",
                        flag = "Remove Weapon Bob"
                    })

                    Sections.Misc.WeaponMods:AddToggle({
                        text = "Remove scope",
                        flag = "Remove Scope"
                    })

                    Sections.Misc.WeaponMods:AddToggle({
                        text = "Full auto",
                        flag = "Full Auto"
                    })

                    Sections.Misc.WeaponMods:AddToggle({
                        text = "Firerate",
                    })
                end

                do -- Movement
                    Sections.Misc.Movement:AddToggle({
                        text = "Speed hack",
                        flag = "Speed Hack"
                    }):AddSlider({
                        flag = "Speed Hack Speed", 
                        min = 1, max = 400, value = 150
                    }):AddBind({
                        flag = "Speed Hack Key",
                        nomouse = true,
                        key = "LeftShift",
                        mode = "hold",
                    })
    
                    Sections.Misc.Movement:AddToggle({
                        text = "Fly hack", 
                        flag = "Fly Hack",

                        tip = "Flying too far off the ground will lead to despawning!"
                    }):AddSlider({
                        flag = "Fly Hack Speed", 
                        min = 1, max = 300, value = 150
                    }):AddBind({
                        flag = "Fly Hack Key", 
                        nomouse = true, 
                        key = "F"
                    })

                    Sections.Misc.Movement:AddToggle({ 
                        text = "Automatic sprint", 
                        flag = "Auto Sprint"
                    })

                    Sections.Misc.Movement:AddToggle({ 
                        text = "Automatic jump",
                        flag = "Auto Jump",

                        tip = "Excessivly jumping may lead to despawning!"
                    }):AddBind({
                        flag = "Auto Jump Key",
                        nomouse = true,
                        key = "Space",
                        mode = "hold"
                    })
                end

                do -- Sounds
                    Sections.Misc.Sounds:AddToggle({
                        text = "Hit sound",
                        flag = "Hit Sound"
                    }):AddList({
                        flag = "Hit Sound Name",

                        values = Libraries.Utilities.GetKeysFromTable(Cheat.Hitsounds),
                        max = 8
                    })

                    Sections.Misc.Sounds:AddSlider({
                        text = "Volume", 
                        flag = "Hit Sound Volume", 
                        min = 0, max = 300, value = 150, 
                        suffix = "%"
                    })

                    Sections.Misc.Sounds:AddButton({
                        text = "Play sound", 
                        
                        callback = function()
                            Modules.AudioSystem.playSoundId(Cheat.Hitsounds[GetConfig("Hit Sound Name", "value")], 1, GetConfig("Hit Sound Volume", "value") / 100)
                        end
                    })
                end

                do -- Event logs
                    Sections.Misc.EventLogs:AddToggle({
                        text = "Enabled",
                        flag = "Event Logs"
                    }):AddList({
                        flag = "Events To Log",

                        values = {"Hits", "Spawns", "Deaths"},
                        multiselect = true,
                        max = 8
                    })
                end

                do -- Other
                    --[[Sections.Misc.Other:AddToggle({ 
                        text = "Serverhop on votekick", 
                        flag = "Serverhop On Votekick",
                    })]]

                    Sections.Misc.Other:AddToggle({ 
                        text = "Chat spammer", 
                        flag = "Chat Spammer",
                    }):AddList({
                        flag = "Chat Spammer Mode",
                        values = Libraries.Utilities.GetKeysFromTable(Cheat.ChatMessages, "Custom"),
                        value = "Nerdy",
                        max = 8
                    }):AddBox({
                        flag = "Chat Spammer Message",
                        value = "litozinnamon is a nigger"
                    })

                    Sections.Misc.Other:AddSlider({
                        text = "Delay", 
                        flag = "Chat Spammer Delay",
                        min = 3, max = 60, value = 10, 
                        suffix = "s"
                    })

                    Sections.Misc.Other:AddToggle({ 
                        text = "Kill say", 
                        flag = "Kill Say",
                    }):AddList({
                        flag = "Kill Say Mode",
                        values = Libraries.Utilities.GetKeysFromTable(Cheat.ChatMessages, "Custom"),
                        value = "Nerdy",
                        max = 8
                    }):AddBox({
                        flag = "Kill Say Message",
                        value = "Get good, get PFHaxx."
                    })
                end

                do -- Fun
                    Sections.Misc.Fun:AddToggle({ 
                        text = "Ragdoll force", 

                        callback = function(state)
                            Modules.PlayerSettingsInterface.setValue("ragdollfunfactor", state and 25 or 0)
                        end
                    })
                end
            end

            do -- Configuration
                do -- Settings
                    Sections.Config.Settings:AddBind({
                        text = "Menu bind",
                        flag = "UI Toggle",
                        nomouse = true,
                        key = "Insert",
        
                        callback = function()
                            Libraries.Interface:Close()
                        end
                    })

                    Sections.Config.Settings:AddButton({ 
                        text = "Copy join script", 

                        callback = function(state)
                            setclipboard('game:GetService("TeleportService"):TeleportToPlaceInstance(' .. tostring(game.PlaceId) .. ', "' .. tostring(game.JobId) .. '")')
                        end
                    })

                    Sections.Config.Settings:AddButton({ 
                        text = "Join new server", 

                        -- TODO: Check if we've been kicked previously, store all the servers as JobIds.
                        callback = function(_)
                            Libraries.Utilities.JoinNewServer()
                        end
                    })

                    Sections.Config.Settings:AddButton({ 
                        text = "Rejoin", 

                        callback = function(state)
                            Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
                        end
                    })

                    if Developer then
                        Sections.Config.Settings:AddButton({
                            text = "Decompile",
                            warning = true,

                            callback = function()
                                Libraries.Interface.Warning.text = "Are you sure you want to decompile the game, this may take a minute or more!"
            
                                if not Libraries.Interface.Warning:Show() then
                                    return
                                end
            
                                loadfile("PF-Haxx/Decompiler.lua")()
                            end
                        })
                    end

                    Sections.Config.Settings:AddButton({ 
                        text = "Unload",
                        warning = true,

                        callback = function(state)
                            Cheat.Unload()
                        end
                    })
                end

                do -- Theme
                    Sections.Config.Theme:AddBox({
                        text = "Menu title", 
                        value = Cheat.Name,

                        callback = function(text)
                            Libraries.Interface.TitleInstance.Text = Cheat.Emoji --[[🎄]] .. " " .. text
                        end
                    })
        
                    Sections.Config.Theme:AddColor({
                        text = "Accent color", 
                        flag = "Menu Accent Color", 
                        color = Cheat.Accent,
                        
                        callback = function(color)
                            if Libraries.Interface.currentTab then
                                Libraries.Interface.currentTab.button.TextColor3 = color
                            end
        
                            for i, instance in Libraries.Interface.theme do
                                instance[(instance.ClassName == "TextLabel" and "TextColor3") or (instance.ClassName == "ImageLabel" and "ImageColor3") or "BackgroundColor3"] = color
                            end
                        end
                    })
                end

                do -- Configuration
                    Sections.Config.Configuration:AddList({
                        text = "Config list", 
                        flag = "Config List",
                        values = Libraries.Interface:GetConfigs(),
                        value = "default",
                        max = 8
                    })
        
                    local ConfigName = Sections.Config.Configuration:AddBox({
                        text = "Config name", 
                        flag = "Config Name"
                    })
        
                    Sections.Config.Configuration:AddButton({
                        text = "Create",
                        
                        callback = function()
                            -- NOTE: Automatically creates our directory.
                            Libraries.Interface:GetConfigs()
        
                            Libraries.Interface.Warning.text = "Create config: '" .. ConfigName.value .. "'"
        
                            if not Libraries.Interface.Warning:Show() then
                                return
                            end
        
                            Libraries.Interface:SaveConfig(ConfigName.value)
                            Libraries.Utilities.Log("Configs", "Successfully created " .. ConfigName.value .. "!")

                            ConfigName.value = ""
                        end
                    })
        
                    Sections.Config.Configuration:AddButton({
                        text = "Load", 
                        
                        callback = function()
                            local ConfigName = GetConfig("Config List").value

                            Libraries.Interface.Warning.text = "Load config: '" .. ConfigName .. "'"
                            
                            if not Libraries.Interface.Warning:Show() then
                                return
                            end
        
                            Libraries.Interface:LoadConfig(ConfigName)
                            Libraries.Utilities.Log("Configs", "Successfully loaded " .. ConfigName .. "!")
                        end
                    })
        
                    Sections.Config.Configuration:AddButton({
                        text = "Save", 
                    
                        callback = function()
                            local ConfigName = GetConfig("Config List").value

                            Libraries.Interface.Warning.text = "Save config: '" .. ConfigName .. "'"
        
                            if not Libraries.Interface.Warning:Show() then
                                return
                            end
        
                            Libraries.Interface:SaveConfig(ConfigName)
                            
                            Libraries.Utilities.Log("Configs", "Successfully saved " .. ConfigName .. "!")
                        end
                    })
        
                    Sections.Config.Configuration:AddButton({
                        text = "Delete", 
                        warning = true,
        
                        callback = function()
                            local ConfigName = GetConfig("Config List").value

                            Libraries.Interface.Warning.text = "Delete config: '" .. ConfigName .. "'"
        
                            if not Libraries.Interface.Warning:Show() then
                                return
                            end
        
                            if table.find(Libraries.Interface:GetConfigs(), ConfigName) 
                            and isfile(Libraries.Interface.foldername .. "\\" .. ConfigName .. Libraries.Interface.fileext) then
                                delfile(Libraries.Interface.foldername .. "\\" .. ConfigName .. Libraries.Interface.fileext)
                            end

                            Libraries.Utilities.Log("Configs", "Successfully deleted " .. ConfigName .. "!")
                        end
                    })
                end
            end
        end

        Libraries.Interface:SaveConfig("Default")

        Libraries.Interface:Init(Vector2.new(730, 600))
        Libraries.Interface:SelectTab(Libraries.Interface.tabs[1])
    end

    Cheat.Unload = function()
        Libraries.Interface:Unload()

        Features.Esp.Destroy()
        Features.Lighting.Destroy()
        Features.Highlights.Destroy()
        Features.ChamsManager.Destroy()

        Features.Misc.Destroy()

        Libraries.Utilities:ClearConnections()
        Hooks:Unload()

        Cheat = nil
    end

    local Seconds = math.floor(os.clock() - StartTime)
    local Milliseconds = math.floor((os.clock() - StartTime - Seconds) * 1000)

    local FormattedTime = string.format("%d.%03d", Seconds, Milliseconds)

    Libraries.Utilities.Log(Cheat.Name, "Successfully loaded, took", FormattedTime .. "s, have fun exploiting!")

    if Developer then
        Libraries.Utilities.Log(Cheat.Name, "You're using the development build, expect bugs!")
    end
end
