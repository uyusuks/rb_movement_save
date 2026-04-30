local rs = game:GetService("ReplicatedStorage")
local uis = game:GetService("UserInputService")
local cas = game:GetService("ContextActionService")
local ps = game:GetService("Players")

local p = ps.LocalPlayer
local ch = p.Character or p.CharacterAdded:Wait()
local hrp = ch:WaitForChild("HumanoidRootPart")

local modules_folder = rs:WaitForChild("modules")
local netray = require(modules_folder:WaitForChild("netray"))

local movement_event = netray:GetEvent("movement")

local run_status = false

local function slide(_, state, _)

    if state ~= Enum.UserInputState.Begin then return end

        local hrp_velocity = hrp.AssemblyLinearVelocity
        local dir = (Vector3.new(hrp_velocity.X, 0, hrp_velocity.Z)).Unit

    if dir.Magnitude == math.huge or dir.Magnitude ~= dir.Magnitude then return end

        movement_event:FireServer({

        movement_type = "slide",
        dir = dir
    })
end

cas:BindAction("slide", slide, false, Enum.KeyCode.Q)

uis.InputBegan:Connect(function(input, gp)
    
    if gp then return end

    if input.KeyCode == Enum.KeyCode.LeftControl then

        movement_event:FireServer({

            movement_type = "run",
            run_status = run_status
        })
    end

    run_status = not run_status
end)
