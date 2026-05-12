--!strict

local rs = game:GetService("ReplicatedStorage") :: ReplicatedStorage
local uis = game:GetService("UserInputService") :: UserInputService
local cas = game:GetService("ContextActionService") :: ContextActionService
local ps = game:GetService("Players") :: Players

local p = ps.LocalPlayer :: Player
local ch: Model = p.Character or p.CharacterAdded:Wait()
local hrp = ch:WaitForChild("HumanoidRootPart") :: BasePart

local modules_folder = rs:WaitForChild("modules") :: Folder
local netray = require(modules_folder:WaitForChild("netray")) :: any

local movement_event = netray:GetEvent("movement") :: any

local run_status = false :: boolean

local function slide(_, state: Enum.UserInputState, _)

	if state ~= Enum.UserInputState.Begin then return end

	local hrp_velocity = hrp.AssemblyLinearVelocity :: Vector3
	local dir = (Vector3.new(hrp_velocity.X, 0, hrp_velocity.Z)).Unit :: Vector3

	if dir.Magnitude == math.huge or dir.Magnitude ~= dir.Magnitude then return end

	movement_event:FireServer({

		movement_type = "slide",
		dir = dir
	})
end

cas:BindAction("slide", slide, false, Enum.KeyCode.Q)

uis.InputBegan:Connect(function(input: InputObject, gp: boolean)

	if gp then return end

	if input.KeyCode == Enum.KeyCode.LeftControl then

		movement_event:FireServer({

			movement_type = "run",
			run_status = run_status
		})
	end

	run_status = not run_status
end)
