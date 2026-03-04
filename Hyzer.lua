-- Hyzer AP Spammer - Steal a Brainrot

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local TweenService     = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

local ADMIN_COMMANDS = {
    ";rocket %s",
    ";ragdoll %s",
    ";balloon %s",
    ";inverse %s",
    ";nightvision %s",
    ";jail %s",
    ";tiny %s",
    ";jumpscare %s",
    ";morph %s",
}

local SPAM_DELAY = 0.1

local function sendChat(msg)
    local ok1 = pcall(function()
        game:GetService("ReplicatedStorage")
            .DefaultChatSystemChatEvents
            .SayMessageRequest:FireServer(msg, "All")
    end)
    if ok1 then return end

    local ok2 = pcall(function()
        game:GetService("TextChatService")
            .TextChannels.RBXGeneral:SendAsync(msg)
    end)
    if ok2 then return end

    pcall(function()
        game:GetService("ReplicatedStorage")
            :FindFirstChild("SayMessageRequest", true):FireServer(msg, "All")
    end)
end

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HyzerAPSpammer"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Toggle Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 44, 0, 44)
ToggleBtn.Position = UDim2.new(1, -54, 1, -54)
ToggleBtn.AnchorPoint = Vector2.new(0, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
ToggleBtn.Text = "✦"
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 20
ToggleBtn.TextColor3 = Color3.fromRGB(160, 140, 255)
ToggleBtn.BorderSizePixel = 0
ToggleBtn.ZIndex = 10
ToggleBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Color = Color3.fromRGB(120, 100, 220)
ToggleStroke.Thickness = 1.5

TweenService:Create(ToggleBtn, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
    TextColor3 = Color3.fromRGB(220, 200, 255)
}):Play()
TweenService:Create(ToggleStroke, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
    Color = Color3.fromRGB(200, 180, 255)
}):Play()

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 360)
MainFrame.AnchorPoint = Vector2.new(1, 1)
MainFrame.Position = UDim2.new(1, -64, 1, -64)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 6, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = false
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

local GlowStroke = Instance.new("UIStroke", MainFrame)
GlowStroke.Color = Color3.fromRGB(90, 70, 180)
GlowStroke.Thickness = 1.5
GlowStroke.Transparency = 0.3

local BgGradient = Instance.new("UIGradient", MainFrame)
BgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(14, 10, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 4, 15)),
})
BgGradient.Rotation = 135

-- Particles
local ParticleContainer = Instance.new("Frame", MainFrame)
ParticleContainer.Size = UDim2.new(1, 0, 1, 0)
ParticleContainer.BackgroundTransparency = 1
ParticleContainer.ClipsDescendants = true
ParticleContainer.ZIndex = 1

local particleData = {
    {0.05,2,0.3,0.6},{0.15,1,0.5,0.4},{0.25,3,0.2,0.7},
    {0.35,1,0.4,0.5},{0.45,2,0.3,0.8},{0.55,1,0.5,0.45},
    {0.65,3,0.2,0.6},{0.75,1,0.4,0.55},{0.85,2,0.3,0.7},
    {0.95,1,0.5,0.4},{0.10,2,0.2,0.65},{0.20,1,0.4,0.5},
    {0.30,3,0.3,0.75},{0.40,1,0.5,0.45},{0.50,2,0.2,0.8},
    {0.60,1,0.4,0.6},{0.70,3,0.3,0.5},{0.80,1,0.5,0.7},
}

local particles = {}
for _, d in ipairs(particleData) do
    local p = Instance.new("Frame")
    p.Size = UDim2.new(0, d[2], 0, d[2])
    p.BackgroundColor3 = Color3.fromRGB(180, 160, 255)
    p.BorderSizePixel = 0
    p.BackgroundTransparency = d[3]
    p.ZIndex = 2
    Instance.new("UICorner", p).CornerRadius = UDim.new(1, 0)
    local sy = math.random(0, 100) / 100
    p.Position = UDim2.new(d[1], 0, sy, 0)
    p.Parent = ParticleContainer
    table.insert(particles, { frame=p, x=d[1], speed=d[4], y=sy, baseTrans=d[3] })
end

-- Title Bar
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.BackgroundTransparency = 1
TitleBar.ZIndex = 3

local TitleLine = Instance.new("Frame", TitleBar)
TitleLine.Size = UDim2.new(0.85, 0, 0, 1)
TitleLine.Position = UDim2.new(0.075, 0, 1, -1)
TitleLine.BackgroundColor3 = Color3.fromRGB(80, 60, 160)
TitleLine.BorderSizePixel = 0
TitleLine.ZIndex = 3
local TitleGrad = Instance.new("UIGradient", TitleLine)
TitleGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0,0,0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120,100,220)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0)),
})

local TitleDot = Instance.new("Frame", TitleBar)
TitleDot.Size = UDim2.new(0, 6, 0, 6)
TitleDot.Position = UDim2.new(0, 12, 0.5, -3)
TitleDot.BackgroundColor3 = Color3.fromRGB(140, 120, 255)
TitleDot.BorderSizePixel = 0
TitleDot.ZIndex = 4
Instance.new("UICorner", TitleDot).CornerRadius = UDim.new(1, 0)

local TitleLabel = Instance.new("TextLabel", TitleBar)
TitleLabel.Size = UDim2.new(1, -50, 1, 0)
TitleLabel.Position = UDim2.new(0, 26, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Hyzer  ·  AP Spammer"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 13
TitleLabel.TextColor3 = Color3.fromRGB(200, 185, 255)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 4

local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -30, 0.5, -12)
CloseBtn.Text = "×"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.BackgroundColor3 = Color3.fromRGB(80, 20, 60)
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 140)
CloseBtn.BorderSizePixel = 0
CloseBtn.ZIndex = 5
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

-- Status label
local StatusLabel = Instance.new("TextLabel", MainFrame)
StatusLabel.Size = UDim2.new(1, -20, 0, 20)
StatusLabel.Position = UDim2.new(0, 10, 0, 42)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "👇 Clique sur un joueur"
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 11
StatusLabel.TextColor3 = Color3.fromRGB(140, 120, 200)
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.ZIndex = 4

-- Player List
local ScrollingFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollingFrame.Position = UDim2.new(0, 10, 0, 68)
ScrollingFrame.Size = UDim2.new(1, -20, 1, -78)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.ScrollBarThickness = 3
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 80, 200)
ScrollingFrame.ZIndex = 3

local ListLayout = Instance.new("UIListLayout", ScrollingFrame)
ListLayout.Padding = UDim.new(0, 5)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder

ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 10)
end)

-- Spam
local isSpamming = false
local function spamCommands(targetName)
    if isSpamming then return end
    isSpamming = true
    StatusLabel.Text = "⚡ Spam sur " .. targetName .. "..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)

    task.spawn(function()
        for _, cmd in ipairs(ADMIN_COMMANDS) do
            local fullCmd = string.format(cmd, targetName)
            sendChat(fullCmd)
            task.wait(SPAM_DELAY)
        end
        isSpamming = false
        StatusLabel.Text = "✅ Terminé sur " .. targetName
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
        task.wait(2)
        StatusLabel.Text = "👇 Clique sur un joueur"
        StatusLabel.TextColor3 = Color3.fromRGB(140, 120, 200)
    end)
end

-- Boutons joueurs
local playerButtons = {}
local function createPlayerButton(player)
    if playerButtons[player] then return end

    local btn = Instance.new("TextButton", ScrollingFrame)
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(18, 14, 40)
    btn.Text = ""
    btn.BorderSizePixel = 0
    btn.ZIndex = 4
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local bStroke = Instance.new("UIStroke", btn)
    bStroke.Color = Color3.fromRGB(60, 45, 120)
    bStroke.Thickness = 1

    local avatar = Instance.new("ImageLabel", btn)
    avatar.Size = UDim2.new(0, 26, 0, 26)
    avatar.Position = UDim2.new(0, 6, 0.5, -13)
    avatar.BackgroundColor3 = Color3.fromRGB(30, 20, 60)
    avatar.BorderSizePixel = 0
    avatar.ZIndex = 5
    avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=48&height=48&format=png"
    Instance.new("UICorner", avatar).CornerRadius = UDim.new(1, 0)

    local nameLabel = Instance.new("TextLabel", btn)
    nameLabel.Size = UDim2.new(1, -50, 1, 0)
    nameLabel.Position = UDim2.new(0, 38, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.Font = Enum.Font.Gotham
    nameLabel.TextSize = 12
    nameLabel.TextColor3 = Color3.fromRGB(180, 165, 255)
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.ZIndex = 5

    local icon = Instance.new("TextLabel", btn)
    icon.Size = UDim2.new(0, 20, 1, 0)
    icon.Position = UDim2.new(1, -24, 0, 0)
    icon.BackgroundTransparency = 1
    icon.Text = "⚡"
    icon.TextSize = 14
    icon.ZIndex = 5

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(50, 30, 90) }):Play()
        TweenService:Create(bStroke, TweenInfo.new(0.15), { Color = Color3.fromRGB(180, 80, 255) }):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(18, 14, 40) }):Play()
        TweenService:Create(bStroke, TweenInfo.new(0.15), { Color = Color3.fromRGB(60, 45, 120) }):Play()
    end)

    btn.MouseButton1Click:Connect(function()
        spamCommands(player.Name)
    end)

    playerButtons[player] = btn
end

local function removePlayerButton(player)
    if playerButtons[player] then
        playerButtons[player]:Destroy()
        playerButtons[player] = nil
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    createPlayerButton(player)
end

Players.PlayerAdded:Connect(createPlayerButton)
Players.PlayerRemoving:Connect(removePlayerButton)

-- Open / Close
local isOpen = true
local function setOpen(open)
    isOpen = open
    if open then
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 260, 0, 0)
        TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 260, 0, 360)
        }):Play()
        ToggleBtn.Text = "✦"
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 260, 0, 0)
        }):Play()
        task.delay(0.3, function()
            if not isOpen then MainFrame.Visible = false end
        end)
        ToggleBtn.Text = "✦"
    end
end

ToggleBtn.MouseButton1Click:Connect(function() setOpen(not isOpen) end)
CloseBtn.MouseButton1Click:Connect(function() setOpen(false) end)
MainFrame.Visible = false
task.delay(0.1, function() setOpen(true) end)

-- Particle + Glow animation
local elapsed = 0
RunService.RenderStepped:Connect(function(dt)
    elapsed += dt
    for _, p in ipairs(particles) do
        p.y = p.y - p.speed * dt * 0.04
        if p.y < -0.05 then
            p.y = 1.05
            p.x = math.random(1, 99) / 100
        end
        local twinkle = math.sin(elapsed * 2 + p.x * 10) * 0.2
        p.frame.Position = UDim2.new(p.x, 0, p.y, 0)
        p.frame.BackgroundTransparency = math.clamp(p.baseTrans + twinkle, 0, 0.95)
    end
    GlowStroke.Color = Color3.fromRGB(
        90 + math.sin(elapsed * 0.7) * 30,
        70 + math.sin(elapsed * 0.5) * 20,
        180 + math.sin(elapsed * 0.9) * 40
    )
end)
