--= Flappy Blox Setup Module by Danael_21 X StarShadow64 =--

--= Main Module =--

return function()
    local InstanceUtil = require(game.ReplicatedStorage:FindFirstChild("ToolibsUtils"):FindFirstChild("InstanceUtil"))
    local AssetFld = InstanceUtil.Instanciate("Folder", game.ReplicatedStorage, {["Name"] = "AssetFolder"})

    for i, assets in pairs(game.Workspace:FindFirstChild("Assets"):GetChildren()) do
        assets.Parent = AssetFld
    end

    local BirdG = InstanceUtil.Instanciate("Model", game.Workspace, {["Name"] = "Bird"})
    local NewBird = InstanceUtil.CloneP(AssetFld:FindFirstChild("BirdAnim1"), {["Parent"] = BirdG, ["Name"] = "BirdAnim"})
    local AnimateScript = InstanceUtil.CloneP(AssetFld:FindFirstChild("AnimScript"), {["Parent"] = BirdG, ["Name"] = "AnimScript", ["Disabled"] = false})

    game.Workspace:FindFirstChild("Assets"):Destroy()
end