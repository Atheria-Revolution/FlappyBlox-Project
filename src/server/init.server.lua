--= Game Initialiser by Danael_21 X StarShadow64 =--

local ToolLibs = game.ReplicatedStorage:FindFirstChild("ToolibsUtils")
local ModuleInit = require(ToolLibs:FindFirstChild("ModuleLoaderUtil"))
local InstanceUtil = require(ToolLibs.InstanceUtil)
local remote = InstanceUtil.Instanciate("RemoteEvent", game.ReplicatedStorage, {["Name"] = "ClickRemote"})
local remote2 = InstanceUtil.Instanciate("RemoteEvent", game.ReplicatedStorage, {["Name"] = "ScoreRemote"})

local GameStarted = false

warn("Setting up Flappy Blox")

local FB = require(script:FindFirstChild("FlappyBlox"))

FB.Setup()

remote.OnServerEvent:Connect(function()
	FB.Jump()
	if GameStarted == false then
		GameStarted = true
		delay(.05, function()
			FB.Start()
		end)
	end
end)