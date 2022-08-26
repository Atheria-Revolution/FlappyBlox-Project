--= Game Initialiser by Danael_21 X StarShadow64 =--

local ToolLibs = game.ReplicatedStorage:FindFirstChild("ToolibsUtils")
local ModuleInit = require(ToolLibs:FindFirstChild("ModuleLoaderUtil"))

warn("Setting up Flappy Blox")
require(script:FindFirstChild("SetupModule"))()

script:FindFirstChild("SetupModule"):Destroy()

ModuleInit.Load(script, true)