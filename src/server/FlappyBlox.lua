local MarketplaceService = game:GetService("MarketplaceService")
--= Flappy Blox Game by Danael_21 X StarShadow64 =--

--= Root =--

local Module = { }

--= Constants =--

local Toolibs = game.ReplicatedStorage:FindFirstChild("ToolibsUtils")
local InstanceUtil = require(Toolibs.InstanceUtil)

--= Variables =--

local GameOver = false
local debounce = 5
local d = false
local MAX_Rotation = -45

--= Functions =--

function SpawnPipe()
    local Pipe = InstanceUtil.CloneP(game.ReplicatedStorage.AssetFolder:FindFirstChild("Pipe"), {["Name"] = "Pipe", ["Parent"] = game.Workspace})

    local rY = math.random(15, 50)

    InstanceUtil.Weld(Pipe:FindFirstChild("MP"), Pipe.Pipe1)
    InstanceUtil.Weld(Pipe:FindFirstChild("MP"), Pipe.Pipe2)

    Pipe:FindFirstChild("MP").CFrame = CFrame.new(Pipe:FindFirstChild("MP").Position.X, rY, Pipe:FindFirstChild("MP").Position.Z)

    local T = game.TweenService:Create(Pipe:FindFirstChild("MP"), TweenInfo.new(15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0), {CFrame = Pipe:FindFirstChild("MP").CFrame - Vector3.new(0,0,110)})
    T:Play()
    wait(15)
    Pipe:Destroy()
end

function Module.StopRotation()

    while true do
        wait()
        if game.Workspace.Bird.BirdAnim1.Orientation.Z > MAX_Rotation then
            game.Workspace.Bird.BirdAnim1.AssemblyAngularVelocity = Vector3.new(0,0,0)
            game.Workspace.Bird.BirdAnim2.AssemblyAngularVelocity = Vector3.new(0,0,0)
            game.Workspace.Bird.BirdAnim3.AssemblyAngularVelocity = Vector3.new(0,0,0)
            game.Workspace.Bird.BirdAnim1.Orientation = Vector3.new(game.Workspace.Bird.BirdAnim3.Orientation.X, game.Workspace.Bird.BirdAnim2.Orientation.Y, MAX_Rotation)
            game.Workspace.Bird.BirdAnim2.Orientation = Vector3.new(game.Workspace.Bird.BirdAnim3.Orientation.X, game.Workspace.Bird.BirdAnim2.Orientation.Y, MAX_Rotation)
            game.Workspace.Bird.BirdAnim3.Orientation = Vector3.new(game.Workspace.Bird.BirdAnim3.Orientation.X, game.Workspace.Bird.BirdAnim2.Orientation.Y, MAX_Rotation)
        end
    end
end

function EndGame(hit)

    if hit.Name == "TriggerPart" and d == false then
        d = true
        game.ReplicatedStorage:FindFirstChild("ScoreRemote"):FireAllClients()
        hit:Destroy()
        wait(0.1)
        d = false
        return nil
    end
    if hit.Parent.Name == "TerrainPart" or hit.Parent.Name == "Pipe1" or hit.Parent.Name == "Pipe2" then
        if GameOver == false then
            game.Workspace:FindFirstChild("Bird"):FindFirstChild("AnimScript"):Destroy()
            for i, parts in pairs(game.Workspace:FindFirstChild("Bird"):GetDescendants()) do
                if parts:IsA("UnionOperation") then
                    parts.CanCollide = true
                    parts.Anchored = false
                end
            end

            GameOver = true
        end
    end
end

function Module.Setup()
    local InstanceUtil = require(game.ReplicatedStorage:FindFirstChild("ToolibsUtils"):FindFirstChild("InstanceUtil"))
    local AssetFld = InstanceUtil.Instanciate("Folder", game.ReplicatedStorage, {["Name"] = "AssetFolder"})

    for i, assets in pairs(game.Workspace:FindFirstChild("Assets"):GetChildren()) do
        assets.Parent = AssetFld
    end

    local NewBird = InstanceUtil.CloneP(AssetFld:FindFirstChild("Bird"), {["Parent"] = game.Workspace, ["Name"] = "Bird"})
    local AnimateScript = InstanceUtil.CloneP(AssetFld:FindFirstChild("AnimScript"), {["Parent"] = NewBird, ["Name"] = "AnimScript", ["Disabled"] = false})

    NewBird:FindFirstChild("BirdAnim1").Touched:Connect(EndGame)

    game.Workspace:FindFirstChild("Assets"):Destroy()
end

function Module.Start()
    print("Starting game")

    while GameOver == false do
        wait(debounce)
        delay(.05, function()
            SpawnPipe()
        end)
    end
end

function Module.Jump()

    local Bird = game.Workspace:FindFirstChild("Bird")

    if Bird  and GameOver == false then
        if Bird.BirdAnim1.Position.Y > 50 then
        else
            Bird.BirdAnim1.Anchored = false
            Bird.BirdAnim1.AssemblyLinearVelocity = Vector3.new(0,35,0)
            Bird.BirdAnim1.AssemblyAngularVelocity = Vector3.new(-8,0,0)
            Bird.BirdAnim2.AssemblyAngularVelocity = Vector3.new(-8,0,0)
            Bird.BirdAnim3.AssemblyAngularVelocity = Vector3.new(-8,0,0)
        end
    end
end

return Module