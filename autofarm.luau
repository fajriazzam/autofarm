-- Simple Hub UI - KRNL Friendly

local plr = game:GetService("Players").LocalPlayer
local cg = game:GetService("CoreGui")

local gui = Instance.new("ScreenGui")
gui.Name = "CustomHub"
gui.Parent = cg
gui.ResetOnSpawn = false

-- Main container
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

-- Sidebar
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 120, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 8)

local sideList = Instance.new("UIListLayout", sidebar)
sideList.Padding = UDim.new(0, 5)
sideList.HorizontalAlignment = Enum.HorizontalAlignment.Center
sideList.SortOrder = Enum.SortOrder.LayoutOrder

-- Content area
local content = Instance.new("Frame", mainFrame)
content.Position = UDim2.new(0, 120, 0, 0)
content.Size = UDim2.new(1, -120, 1, 0)
content.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Instance.new("UICorner", content).CornerRadius = UDim.new(0, 8)

-- Title
local title = Instance.new("TextLabel", sidebar)
title.Size = UDim2.new(1, -10, 0, 30)
title.Text = "Speed Hub X"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.BackgroundTransparency = 1

-- Sidebar buttons
local tabs = {"Main", "Automatically", "Inventory", "Shop", "Misc", "Settings"}

local buttons = {}

for _, name in ipairs(tabs) do
    local b = Instance.new("TextButton", sidebar)
    b.Size = UDim2.new(1, -10, 0, 30)
    b.Text = name
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Gotham
    b.TextScaled = true
    b.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    table.insert(buttons, b)
end

-- Example: Content buttons for "Main"
local function loadMainPage()
    content:ClearAllChildren()

    local layout = Instance.new("UIListLayout", content)
    layout.Padding = UDim.new(0, 5)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.VerticalAlignment = Enum.VerticalAlignment.Top

    local options = {
        "Automation Plants",
        "Automation Collection",
        "Automation Sprinkler",
        "Automation Eggs",
        "Automation Sell"
    }

    for _, text in ipairs(options) do
        local btn = Instance.new("TextButton", content)
        btn.Size = UDim2.new(0, 250, 0, 35)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.Gotham
        btn.TextScaled = true
        btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

        btn.MouseButton1Click:Connect(function()
            print(text .. " clicked!")
            -- Ganti ini dengan action script kamu!
        end)
    end
end

-- Link sidebar to content
for _, b in ipairs(buttons) do
    b.MouseButton1Click:Connect(function()
        if b.Text == "Main" then
            loadMainPage()
        else
            content:ClearAllChildren()
            local lbl = Instance.new("TextLabel", content)
            lbl.Size = UDim2.new(1, 0, 1, 0)
            lbl.Text = b.Text .. " page"
            lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
            lbl.Font = Enum.Font.GothamBold
            lbl.TextScaled = true
            lbl.BackgroundTransparency = 1
        end
    end)
end

-- Load default
loadMainPage()
