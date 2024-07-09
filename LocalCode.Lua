local Player = game.Players.LocalPlayer
local leaderstats = Player:WaitForChild("leaderstats")
local Level = leaderstats:FindFirstChild("Level")

local Passes = {"X2Speed", "X4Speed", "X2Coins"}
local PassesID = {X2Speed = 769211430, X4Speed = 769249511, X2Coins = 769448521}
local PassesImage = {X2Speed = 1, X4Speed = 2, X2Coins = 3}

local Event = game.ReplicatedStorage:FindFirstChild("Respawn")
local MarketPlaceService = game:GetService("MarketplaceService")

-- UI Elements
local MenuFrame = script.Parent.MenuFrame
local GamepassesFrame = script.Parent.GamepassesFrame
local MenuButton = script.Parent.Menu
local PassesButton = script.Parent.Passes
local ShopButton = script.Parent.EnterButton.ShopButton
local CloseButton = script.Parent.X
local debounce = true

-- Color Settings
local BackGroundSelecttedColor = Color3.new(255/255, 234/255, 0/255)
local StrokeSelecttedColor = Color3.new(91/255, 88/255, 0/255)
local UIStrokeSelecttedColor = Color3.new(91/255, 93/255, 0/255)

local BackGroundColor = Color3.new(55/255, 255/255, 0/255)
local StrokeColor = Color3.new(14/255, 135/255, 0/255)
local UIStrokeColor = Color3.new(0/255, 93/255, 11/255)

local function update()
    local TextLabel = MenuFrame.Rank
    for i, Label in pairs(MenuFrame.Frame:GetChildren()) do
        if Label.Name == Level.Value then
            TextLabel.Text = Label.Text
            TextLabel.TextColor3 = Label.TextColor3
            TextLabel.UIStroke.Color = Label.UIStroke.Color
        end
    end
end
update()

local function sound(Type)
    local Sound = script.Parent.Sound:FindFirstChild(Type)
    Sound:Play()
end

local function Color(Qual)
    if Qual == "Menu" then
        MenuButton.BackgroundColor3 = BackGroundSelecttedColor
        MenuButton.TextStrokeColor3 = StrokeSelecttedColor
        MenuButton.UIStroke.Color = UIStrokeSelecttedColor
        
        PassesButton.BackgroundColor3 = BackGroundColor
        PassesButton.TextStrokeColor3 = StrokeColor
        PassesButton.UIStroke.Color = UIStrokeColor
        
        MenuFrame.Visible = true
        GamepassesFrame.Visible = false
    elseif Qual == "Passes" then
        PassesButton.BackgroundColor3 = BackGroundSelecttedColor
        PassesButton.TextStrokeColor3 = StrokeSelecttedColor
        PassesButton.UIStroke.Color = UIStrokeSelecttedColor
        
        MenuButton.BackgroundColor3 = BackGroundColor
        MenuButton.TextStrokeColor3 = StrokeColor
        MenuButton.UIStroke.Color = UIStrokeColor
        
        GamepassesFrame.Visible = true
        MenuFrame.Visible = false
    end
end

local function handleGamePassPurchase(Button)
    local ID = PassesID[Button.Name]
    if ID then
        MarketPlaceService:PromptGamePassPurchase(Player, ID)
        sound("Click")
    else
        warn("Invalid Game Pass ID for button: " .. Button.Name)
    end
end

local function initializeGamepasses()
    for _, Button in pairs(GamepassesFrame.Gamepasses:GetChildren()) do
        if table.find(Passes, Button.Name) then
            local ImageID = PassesImage[Button.Name]
            Button.ImageLabel.Image = "rbxassetid://" .. ImageID
            Button.Comprar.MouseButton1Click:Connect(function()
                handleGamePassPurchase(Button)
            end)
            Button.Comprar.MouseEnter:Connect(function()
                sound("Enter")
            end)
        else
            Button.ImageLabel.Visible = false
            Button.Comprar.Visible = false
        end
    end
end

local function debugMessage(message)
    print("[DEBUG]: " .. message)
end

local function handleMenuButtonClick()
    Color("Menu")
    sound("Click")
    debugMessage("Menu button clicked.")
end


local function handlePassesButtonClick()
    Color("Passes")
    sound("Click")
    debugMessage("Passes button clicked.")
end

local function handleCloseButtonClick()
    script.Parent.Enabled = false
    sound("Click")
    debugMessage("Close button clicked.")
end

local function handleShopButtonClick()
    sound("Click")
    debugMessage("Shop button clicked.")
    if debounce then
        debounce = false
        update()
        script.Parent.Enabled = true
        Color("Passes")
    else
        debounce = true
        script.Parent.Enabled = false
    end
end

-- Event connections for UI buttons
local function setupEventListeners()
    MenuButton.MouseButton1Click:Connect(handleMenuButtonClick)

    PassesButton.MouseButton1Click:Connect(handlePassesButtonClick)

    CloseButton.MouseButton1Click:Connect(handleCloseButtonClick)

    MenuButton.MouseEnter:Connect(function()
        sound("Enter")
    end)

    PassesButton.MouseEnter:Connect(function()
        sound("Enter")
    end)

    CloseButton.MouseEnter:Connect(function()
        sound("Enter")
    end)

    ShopButton.MouseEnter:Connect(function()
        sound("Enter")
    end)

    ShopButton.MouseButton1Click:Connect(handleShopButtonClick)

    script.Parent.MenuFrame.Ponto.MouseEnter:Connect(function()
        script.Parent.MenuFrame.MessageBox1.Visible = true
        script.Parent.MenuFrame.MessageBox2.Visible = true
    end)

    script.Parent.MenuFrame.Ponto.MouseLeave:Connect(function()
        script.Parent.MenuFrame.MessageBox1.Visible = false
        script.Parent.MenuFrame.MessageBox2.Visible = false
    end)

    script.Parent.EnterButton.MenuButton.MouseButton1Click:Connect(function()
        sound("Click")
        script.Parent.Enabled = true
        MenuFrame.Visible = true
    end)

    script.Parent.EnterButton.MenuButton.MouseEnter:Connect(function()
        sound("Enter")
    end)

    Level.Changed:Connect(update)
end

-- Function to handle initialization errors
local function handleError(errorMessage)
    warn("Error: " .. errorMessage)
end

-- Function to perform additional setup
local function additionalSetup()
    debugMessage("Performing additional setup...")
    -- Additional setup code here
    -- For example, checking player's current game passes
    for _, pass in pairs(Passes) do
        local hasPass = MarketPlaceService:UserOwnsGamePassAsync(Player.UserId, PassesID[pass])
        if hasPass then
            debugMessage("Player owns pass: " .. pass)
        else
            debugMessage("Player does not own pass: " .. pass)
        end
    end
end

local function welcomePlayer()
    local welcomeMessage = "Welcome to the game, " .. Player.Name .. "!"
    script.Parent.WelcomeMessage.Text = welcomeMessage
    script.Parent.WelcomeMessage.Visible = true
    wait(5)
    script.Parent.WelcomeMessage.Visible = false
    debugMessage("Welcome message displayed.")
end

local function displayPlayerScore()
    local score = leaderstats:FindFirstChild("Score")
    if score then
        local scoreText = "Score: " .. score.Value
        script.Parent.ScoreDisplay.Text = scoreText
        script.Parent.ScoreDisplay.Visible = true
    else
        warn("Score not found in leaderstats.")
    end
end

local function showSpecialOffers()
    script.Parent.SpecialOffers.Visible = true
    script.Parent.SpecialOffers.Text = "Special Offers Available Now!"
    wait(10)
    script.Parent.SpecialOffers.Visible = false
    debugMessage("Special offers message displayed.")
end

local function initializeScript()
    debugMessage("Initializing script...")
    local success, errorMessage = pcall(function()
        initializeGamepasses()
        setupEventListeners()
        additionalSetup()
        welcomePlayer()
        displayPlayerScore()
        showSpecialOffers()
    end)
    if not success then
        handleError(errorMessage)
    end
    debugMessage("Script initialized.")
end

initializeScript()
