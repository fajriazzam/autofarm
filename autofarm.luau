-- Modern Simple Hub UI

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Utility functions
local function create(instanceType, props, parent)
    local obj = Instance.new(instanceType)
    for k, v in pairs(props or {}) do
        obj[k] = v
    end
    if parent then obj.Parent = parent end
    return obj
end

local function roundify(obj, radius)
    create("UICorner", {CornerRadius = UDim.new(0, radius or 8)}, obj)
end

-- Main GUI
local gui = create("ScreenGui", {Name = "CustomHub", ResetOnSpawn = false}, CoreGui)

local mainFrame = create("Frame", {
    Size = UDim2.new(0, 480, 0, 260),
    Position = UDim2.new(0.5, -240, 0.5, -130),
    BackgroundColor3 = Color3.fromRGB(36, 37, 42),
    Active = true,
    Draggable = true
}, gui)
roundify(mainFrame, 12)

-- Sidebar
local sidebar = create("Frame", {
    Size = UDim2.new(0, 110, 1, 0),
    BackgroundColor3 = Color3.fromRGB(28, 29, 34)
}, mainFrame)
roundify(sidebar, 10)

create("UIListLayout", {
    Padding = UDim.new(0, 6),
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder
}, sidebar)

-- Content area
local content = create("Frame", {
    Position = UDim2.new(0, 110, 0, 0),
    Size = UDim2.new(1, -110, 1, 0),
    BackgroundColor3 = Color3.fromRGB(44, 45, 50)
}, mainFrame)
roundify(content, 10)

-- Top-right control buttons (must be after sidebar/content so variables exist)
local controlBar = create("Frame", {
    Size = UDim2.new(0, 60, 0, 28),
    Position = UDim2.new(1, -68, 0, 8),
    BackgroundTransparency = 1
}, mainFrame)

local function makeControlButton(txt, color)
    local btn = create("TextButton", {
        Size = UDim2.new(0, 24, 0, 24),
        BackgroundColor3 = Color3.fromRGB(60, 60, 70),
        Text = txt,
        TextColor3 = color or Color3.fromRGB(255,255,255),
        Font = Enum.Font.GothamBold,
        TextScaled = true,
        AutoButtonColor = true,
        BorderSizePixel = 0
    }, controlBar)
    roundify(btn, 6)
    return btn
end

local minimizeBtn = makeControlButton("-", Color3.fromRGB(255, 220, 80))
minimizeBtn.Position = UDim2.new(0, 0, 0, 0)

local closeBtn = makeControlButton("×", Color3.fromRGB(255, 80, 80))
closeBtn.Position = UDim2.new(0, 32, 0, 0)

local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    sidebar.Visible = not minimized
    content.Visible = not minimized
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Sidebar Title
create("TextLabel", {
    Size = UDim2.new(1, -12, 0, 32),
    Text = "Speed Hub X",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.GothamBold,
    TextScaled = true,
    BackgroundTransparency = 1
}, sidebar)

-- Sidebar Tabs
local tabs = {"Main", "Automatically", "Inventory", "Shop", "Misc", "Settings"}
local buttons = {}

local function makeSidebarButton(name)
    local btn = create("TextButton", {
        Size = UDim2.new(1, -12, 0, 28),
        Text = name,
        TextColor3 = Color3.fromRGB(230, 230, 230),
        Font = Enum.Font.Gotham,
        TextScaled = true,
        BackgroundColor3 = Color3.fromRGB(60, 60, 70),
        AutoButtonColor = true
    }, sidebar)
    roundify(btn, 7)
    return btn
end

for _, name in ipairs(tabs) do
    table.insert(buttons, makeSidebarButton(name))
end

-- Content Pages
local function clearContent()
    for _, v in ipairs(content:GetChildren()) do
        if not v:IsA("UICorner") then v:Destroy() end
    end
end

local function loadMainPage()
    clearContent()
    create("UIListLayout", {
        Padding = UDim.new(0, 7),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Top
    }, content)
    local options = {
        "Automation Plants",
        "Automation Collection",
        "Automation Sprinkler",
        "Automation Eggs",
        "Automation Sell"
    }
    for _, text in ipairs(options) do
        local btn = create("TextButton", {
            Size = UDim2.new(0, 220, 0, 32),
            Text = text,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Font = Enum.Font.Gotham,
            TextScaled = true,
            BackgroundColor3 = Color3.fromRGB(70, 70, 80),
            AutoButtonColor = true
        }, content)
        roundify(btn, 7)
        btn.MouseButton1Click:Connect(function()
            print(text .. " clicked!")
            -- Replace with your action script
        end)
    end
end

local function loadSimplePage(name)
    clearContent()
    create("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        Text = name .. " page",
        TextColor3 = Color3.fromRGB(220, 220, 220),
        Font = Enum.Font.GothamBold,
        TextScaled = true,
        BackgroundTransparency = 1
    }, content)
end

-- Sidebar Button Events
for i, b in ipairs(buttons) do
    b.MouseButton1Click:Connect(function()
        for _, btn in ipairs(buttons) do
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        end
        b.BackgroundColor3 = Color3.fromRGB(90, 90, 120)
        if b.Text == "Main" then
            loadMainPage()
        else
            loadSimplePage(b.Text)
        end
    end)
end

-- Load default page
buttons[1].BackgroundColor3 = Color3.fromRGB(90, 90, 120)
loadMainPage()
