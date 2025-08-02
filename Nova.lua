--// Anti Detection
pcall(function()
    for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do
        v:Disable()
    end
end)

--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")
local Player = Players.LocalPlayer

-- Hidden features
local godModeEnabled = true
local antiResetEnabled = true
local antiDeathEnabled = true

RunService.Stepped:Connect(function()
    if godModeEnabled and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        local hum = Player.Character:FindFirstChild("Humanoid")
        if hum.Health < hum.MaxHealth then hum.Health = hum.MaxHealth end
        if antiDeathEnabled then
            hum.BreakJointsOnDeath = false
            hum.RequiresNeck = false
        end
    end
end)

if antiResetEnabled then
    local resetBindable = Instance.new("BindableEvent")
    resetBindable.Event:Connect(function() return Enum.HumanoidStateType.Physics end)
    StarterGui:SetCore("ResetButtonCallback", resetBindable)
end

--// Notify
local function Notify(msg)
    StarterGui:SetCore("SendNotification",{
        Title = "Nova GUI",
        Text = msg,
        Duration = 4
    })
end

--// GUI Creation
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "NovaUI"

local ToggleButton = Instance.new("ImageButton", ScreenGui)
ToggleButton.Size = UDim2.new(0,50,0,50)
ToggleButton.Position = UDim2.new(1,-60,0,10)
ToggleButton.Image = "rbxassetid://128960552428656"
ToggleButton.BackgroundTransparency = 1
ToggleButton.Draggable = true
Instance.new("UICorner",ToggleButton).CornerRadius = UDim.new(1,0)
Instance.new("UIStroke",ToggleButton).Color = Color3.fromRGB(255,255,255)

local BorderFrame = Instance.new("Frame",ScreenGui)
BorderFrame.AnchorPoint = Vector2.new(0.5,0.5)
BorderFrame.Position = UDim2.new(0.5,0,0.5,0)
BorderFrame.Size = UDim2.new(0,300,0,300)
BorderFrame.BackgroundColor3 = Color3.fromRGB(0,100,200)
BorderFrame.Visible = false
BorderFrame.Active = true
BorderFrame.Draggable = true
Instance.new("UICorner",BorderFrame).CornerRadius = UDim.new(0,12)

local MainFrame = Instance.new("Frame",BorderFrame)
MainFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
MainFrame.Position = UDim2.new(0,2,0,2)
MainFrame.Size = UDim2.new(1,-4,1,-4)
Instance.new("UICorner",MainFrame).CornerRadius = UDim.new(0,10)

local TopBar = Instance.new("Frame",MainFrame)
TopBar.Size = UDim2.new(1,0,0,35)
TopBar.BackgroundColor3 = Color3.fromRGB(0,132,255)
Instance.new("UICorner",TopBar).CornerRadius = UDim.new(0,8)

local Title = Instance.new("TextLabel",TopBar)
Title.Size = UDim2.new(1,0,1,0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "@NovaScripters"
Title.TextSize = 16
Title.TextColor3 = Color3.fromRGB(255,255,255)

local TabsFrame = Instance.new("Frame",MainFrame)
TabsFrame.Position = UDim2.new(0,0,0,40)
TabsFrame.Size = UDim2.new(1,0,0,30)
TabsFrame.BackgroundTransparency = 1

local function createTab(name,pos)
    local btn = Instance.new("TextButton",TabsFrame)
    btn.Text = name
    btn.Size = UDim2.new(1/3,0,1,0)
    btn.Position = UDim2.new(pos,0,0,0)
    btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    Instance.new("UICorner",btn).CornerRadius = UDim.new(0,6)
    return btn
end

local MainTab = createTab("Main",0)
local MiscTab = createTab("Misc",1/3)
local VisualTab = createTab("Visual",2/3)

local function createContent()
    local frame = Instance.new("Frame",MainFrame)
    frame.Position = UDim2.new(0,0,0,75)
    frame.Size = UDim2.new(1,0,1,-75)
    frame.BackgroundTransparency = 1
    frame.Visible = false
    return frame
end

local MainContent = createContent()
local MiscContent = createContent()
local VisualContent = createContent()

local ActiveColor = Color3.fromRGB(0,100,200)
local OffColor = Color3.fromRGB(60,60,60)

local function setActiveTab(tab)
    MainContent.Visible = (tab=="Main")
    MiscContent.Visible = (tab=="Misc")
    VisualContent.Visible = (tab=="Visual")
    MainTab.BackgroundColor3 = (tab=="Main") and ActiveColor or OffColor
    MiscTab.BackgroundColor3 = (tab=="Misc") and ActiveColor or OffColor
    VisualTab.BackgroundColor3 = (tab=="Visual") and ActiveColor or OffColor
end
MainTab.MouseButton1Click:Connect(function() setActiveTab("Main") end)
MiscTab.MouseButton1Click:Connect(function() setActiveTab("Misc") end)
VisualTab.MouseButton1Click:Connect(function() setActiveTab("Visual") end)
setActiveTab("Main")

local function createButton(name,parent,pos)
    local btn = Instance.new("TextButton",parent)
    btn.Position = UDim2.new(0.1,0,0,pos)
    btn.Size = UDim2.new(0.8,0,0,40)
    btn.BackgroundColor3 = OffColor
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Text = name.." OFF"
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    Instance.new("UICorner",btn).CornerRadius = UDim.new(0,8)
    return btn
end

-- Buttons in Main tab
local InfiniteJumpToggle = createButton("🦘 Infinite Jump",MainContent,10)
local JumpBoostToggle = createButton("🌀 Jump Booster",MainContent,60)
local SpeedBoostToggle = createButton("⚡ Speed Boost",MainContent,110)
local ShopBringerToggle = createButton("🛒 Shop bringer", MainContent, 160)

-- Buttons in Visual tab
local PlayerEspToggle = createButton("👁 Player ESP",VisualContent,10)
local AntiInvisibleToggle = createButton("📦 Anti Invisible",VisualContent,60)
local EspBaseTimeToggle = createButton("⏳ Base Timer ESP",VisualContent,110)
local EspBrainrotsToggle = createButton("🐾 Brainrot ESP",VisualContent,160)

-- Buttons in Misc tab
local JoinVCToggle = createButton("🔊 Join VC Server",MiscContent,10)
local RejoinToggle = createButton("🔁 Rejoin",MiscContent,60)
local ServerHopToggle = createButton("🌐 Server Hop",MiscContent,110)
local AntiRagdollToggle = createButton("🦾 Anti Ragdoll",MiscContent,160)

-- Features
local infJumpEnabled=false
UIS.JumpRequest:Connect(function()
    if infJumpEnabled and Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
        Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)
InfiniteJumpToggle.MouseButton1Click:Connect(function()
    infJumpEnabled = not infJumpEnabled
    InfiniteJumpToggle.Text = "🦘 Infinite Jump: "..(infJumpEnabled and "ON" or "OFF")
    InfiniteJumpToggle.BackgroundColor3 = infJumpEnabled and ActiveColor or OffColor
end)

local jumpBoost=false
JumpBoostToggle.MouseButton1Click:Connect(function()
    jumpBoost = not jumpBoost
    JumpBoostToggle.Text = "🌀 Jump Booster: "..(jumpBoost and "ON" or "OFF")
    JumpBoostToggle.BackgroundColor3 = jumpBoost and ActiveColor or OffColor
    if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
        Player.Character:FindFirstChildOfClass("Humanoid").UseJumpPower=true
        Player.Character:FindFirstChildOfClass("Humanoid").JumpPower = jumpBoost and 100 or 50
    end
end)

-- Speed Boost
local speedBoost=false
SpeedBoostToggle.MouseButton1Click:Connect(function()
    speedBoost = not speedBoost
    SpeedBoostToggle.Text = "⚡ Speed Boost: "..(speedBoost and "ON" or "OFF")
    SpeedBoostToggle.BackgroundColor3 = speedBoost and ActiveColor or OffColor
    if speedBoost then
        loadstring(game:HttpGet("https://pastefy.app/alGttyX4/raw",true))()
    else
        if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
            Player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
        end
    end
end)

-- Player ESP / Anti Invisible
local espEnabled=false
local boxEnabled=false
local espObjects = {}

local function addPlayerESP(plr)
    if plr==Player or not plr.Character then return end
    if espObjects[plr] then return end
    local char=plr.Character
    local hrp=char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local highlight=Instance.new("Highlight")
    highlight.Name="NovaESPHighlight"
    highlight.FillTransparency=1
    highlight.OutlineColor=Color3.fromRGB(0,255,0)
    highlight.Parent=char

    local billboard=Instance.new("BillboardGui")
    billboard.Name="NovaESPName"
    billboard.Adornee=hrp
    billboard.Size=UDim2.new(0,200,0,50)
    billboard.StudsOffset=Vector3.new(0,3,0)
    billboard.AlwaysOnTop=true
    local text=Instance.new("TextLabel",billboard)
    text.BackgroundTransparency=1
    text.Size=UDim2.new(1,0,1,0)
    text.Text=plr.Name
    text.TextColor3=Color3.fromRGB(255,255,255)
    text.Font=Enum.Font.GothamBold
    text.TextSize=14
    billboard.Parent=char

    local box=Instance.new("BoxHandleAdornment")
    box.Name="NovaESPBox"
    box.Adornee=hrp
    box.Size=Vector3.new(4,6,2)
    box.Color3=Color3.fromRGB(255,0,0)
    box.Transparency=0.5
    box.AlwaysOnTop=true
    box.ZIndex=2
    box.Visible=boxEnabled
    box.Parent=hrp

    espObjects[plr]={highlight=highlight,billboard=billboard,box=box}
end
local function removePlayerESP(plr)
    if espObjects[plr] then
        for _,v in pairs(espObjects[plr]) do if v and v.Destroy then v:Destroy() end end
        espObjects[plr]=nil
    end
end
local function togglePlayerESP(state)
    espEnabled=state
    for _,plr in pairs(Players:GetPlayers()) do
        if state then addPlayerESP(plr) else removePlayerESP(plr) end
    end
end
local function toggleAntiInvisibleBox(state)
    boxEnabled=state
    for _,obj in pairs(espObjects) do if obj.box then obj.box.Visible=state end end
end
Players.PlayerAdded:Connect(function(plr) plr.CharacterAdded:Connect(function() if espEnabled then addPlayerESP(plr) end end) end)
Players.PlayerRemoving:Connect(removePlayerESP)
PlayerEspToggle.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    PlayerEspToggle.Text = "👁 Player ESP: "..(espEnabled and "ON" or "OFF")
    PlayerEspToggle.BackgroundColor3 = espEnabled and ActiveColor or OffColor
    togglePlayerESP(espEnabled)
end)
AntiInvisibleToggle.MouseButton1Click:Connect(function()
    boxEnabled = not boxEnabled
    AntiInvisibleToggle.Text = "📦 Anti Invisible: "..(boxEnabled and "ON" or "OFF")
    AntiInvisibleToggle.BackgroundColor3 = boxEnabled and ActiveColor or OffColor
    toggleAntiInvisibleBox(boxEnabled)
end)

-- Base Timer ESP / Brainrot ESP
local baseTimerOn=false
local brainrotOn=false
local baseScript, brainrotScript
EspBaseTimeToggle.MouseButton1Click:Connect(function()
    baseTimerOn = not baseTimerOn
    EspBaseTimeToggle.BackgroundColor3 = baseTimerOn and ActiveColor or OffColor
    if baseTimerOn then
        baseScript = loadstring(game:HttpGet("https://pastebin.com/raw/iWzheYra"))()
    else
        if baseScript and type(baseScript)=="function" then pcall(baseScript) end
        baseScript=nil
    end
end)
EspBrainrotsToggle.MouseButton1Click:Connect(function()
    brainrotOn = not brainrotOn
    EspBrainrotsToggle.BackgroundColor3 = brainrotOn and ActiveColor or OffColor
    if brainrotOn then
        brainrotScript = loadstring(game:HttpGet("https://pastebin.com/raw/zsbhqtbp"))()
    else
        if brainrotScript and type(brainrotScript)=="function" then pcall(brainrotScript) end
        brainrotScript=nil
    end
end)

-- Misc buttons
JoinVCToggle.MouseButton1Click:Connect(function() TeleportService:Teleport(game.PlaceId, Player) end)
RejoinToggle.MouseButton1Click:Connect(function() TeleportService:Teleport(game.PlaceId, Player) end)
ServerHopToggle.MouseButton1Click:Connect(function()
    local servers=HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")).data
    for _,v in pairs(servers) do if v.playing < v.maxPlayers then TeleportService:TeleportToPlaceInstance(game.PlaceId, v.id, Player) break end end
end)
AntiRagdollToggle.MouseButton1Click:Connect(function()
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        Notify("Anti Ragdoll Activated")
    end
end)

-- Shop bringer variables
local ShopBringerEnabled = false
local ShopBringerModel = nil

ShopBringerToggle.MouseButton1Click:Connect(function()
    ShopBringerEnabled = not ShopBringerEnabled
    ShopBringerToggle.Text = "🛒 Shop bringer: "..(ShopBringerEnabled and "ON" or "OFF")
    ShopBringerToggle.BackgroundColor3 = ShopBringerEnabled and ActiveColor or OffColor
    
    if ShopBringerEnabled then
        -- Spawn/load the shop bringer model
        local success, err = pcall(function()
            local result = loadstring(game:HttpGet("https://pastebin.com/raw/zEd0T7rd", true))()
            ShopBringerModel = result or nil
        end)
        if not success then
            Notify("Failed to load Shop bringer: "..tostring(err))
            ShopBringerEnabled = false
            ShopBringerToggle.Text = "🛒 Shop bringer: OFF"
            ShopBringerToggle.BackgroundColor3 = OffColor
        else
            Notify("Shop bringer enabled!")
        end
    else
        -- Remove the spawned shop bringer model if exists
        if ShopBringerModel and ShopBringerModel.Parent then
            ShopBringerModel:Destroy()
            ShopBringerModel = nil
        else
            -- Fallback: try to find model in workspace and destroy
            local model = workspace:FindFirstChild("ShopBringer") or workspace:FindFirstChildWhichIsA("Model")
            if model then model:Destroy() end
        end
        Notify("Shop bringer disabled and removed")
    end
end)

-- GUI open/close
local guiOpen=false
ToggleButton.MouseButton1Click:Connect(function()
    guiOpen = not guiOpen
    if guiOpen then
        BorderFrame.Visible=true
        BorderFrame.Size = UDim2.new(0,0,0,0)
        TweenService:Create(BorderFrame,TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(0,300,0,300)}):Play()
    else
        local t=TweenService:Create(BorderFrame,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Size=UDim2.new(0,0,0,0)})
        t:Play()
        t.Completed:Connect(function() BorderFrame.Visible=false BorderFrame.Size=UDim2.new(0,300,0,300) end)
    end
end)
