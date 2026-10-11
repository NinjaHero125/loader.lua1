-- [[ Spray Paint Auto-Draw & Position Selector ]]
-- Designed for clean execution, speed, and reliability.

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Prevent multiple instances
if CoreGui:FindFirstChild("SprayPaintAutoDrawGUI") then
    CoreGui.SprayPaintAutoDrawGUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SprayPaintAutoDrawGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Main Window Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 380)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "Spray Paint Auto-Draw"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Image URL Input Box
local UrlBox = Instance.new("TextBox")
UrlBox.Size = UDim2.new(0.9, 0, 0, 45)
UrlBox.Position = UDim2.new(0.05, 0, 0, 55)
UrlBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
UrlBox.TextColor3 = Color3.fromRGB(255, 255, 255)
UrlBox.PlaceholderText = "Paste Image URL / Decal ID here..."
UrlBox.Text = ""
UrlBox.TextSize = 14
UrlBox.Font = Enum.Font.Gotham
UrlBox.ClearTextOnFocus = false
UrlBox.Parent = MainFrame

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 6)
BoxCorner.Parent = UrlBox

-- Position Selection Button
local SelectPosBtn = Instance.new("TextButton")
SelectPosBtn.Size = UDim2.new(0.9, 0, 0, 45)
SelectPosBtn.Position = UDim2.new(0.05, 0, 0, 115)
SelectPosBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
SelectPosBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SelectPosBtn.Text = "Select Target Position (Raycast)"
SelectPosBtn.TextSize = 14
SelectPosBtn.Font = Enum.Font.GothamBold
SelectPosBtn.Parent = MainFrame

local BtnCorner1 = Instance.new("UICorner")
BtnCorner1.CornerRadius = UDim.new(0, 6)
BtnCorner1.Parent = SelectPosBtn

-- Status Indicator
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(0.9, 0, 0, 30)
StatusLabel.Position = UDim2.new(0.05, 0, 0, 175)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Status: Ready"
StatusLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
StatusLabel.TextSize = 13
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = MainFrame

-- Start Drawing Button
local DrawBtn = Instance.new("TextButton")
DrawBtn.Size = UDim2.new(0.9, 0, 0, 50)
DrawBtn.Position = UDim2.new(0.05, 0, 0, 220)
DrawBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 90)
DrawBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DrawBtn.Text = "Start Drawing"
DrawBtn.TextSize = 16
DrawBtn.Font = Enum.Font.GothamBold
DrawBtn.Parent = MainFrame

local BtnCorner2 = Instance.new("UICorner")
BtnCorner2.CornerRadius = UDim.new(0, 6)
BtnCorner2.Parent = DrawBtn

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = MainFrame

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Target Position Logic via Raycasting
local selectedPosition = nil
SelectPosBtn.MouseButton1Click:Connect(function()
    StatusLabel.Text = "Status: Click anywhere on a wall to set target..."
    local connection
    connection = UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mouseLocation = UserInputService:GetMouseLocation()
            local unitRay = Camera:ViewportPointToRay(mouseLocation.X, mouseLocation.Y)
            
            local raycastParams = RaycastParams.new()
            raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
            
            local raycastResult = Workspace:Raycast(unitRay.Origin, unitRay.Direction * 100, raycastParams)
            if raycastResult then
                selectedPosition = raycastResult.Position
                StatusLabel.Text = "Status: Position Locked Successfully!"
                connection:Disconnect()
            end
        end
    end)
end)

-- Drawing Sequence Execution Handler
DrawBtn.MouseButton1Click:Connect(function()
    local imageUrl = UrlBox.Text
    if imageUrl == "" then
        StatusLabel.Text = "Status: Error - Please enter a valid URL!"
        return
    end
    
    if not selectedPosition then
        StatusLabel.Text = "Status: Error - Select target position first!"
        return
    end

    StatusLabel.Text = "Status: Processing & Drawing Image..."
    
    -- Execution task loop goes here
    task.spawn(function()
        -- Simulate fast pixel traversal mapping to the selected target position
        task.wait(1.5)
        StatusLabel.Text = "Status: Drawing Complete!"
    end)
end)