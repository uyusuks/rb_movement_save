local rs: ReplicatedStorage = game:GetService("ReplicatedStorage")
local uis: UserInputService = game:GetService("UserInputService")
local cas: ContextActionService = game:GetService("ContextActionService")
local ps: Players = game:GetService("Players")

local p: Player? = ps.LocalPlayer
local ch: Model = p.Character or p.CharacterAdded:Wait()
local hrp: BasePart = ch:WaitForChild("HumanoidRootPart")

local modules_folder: Folder = rs:WaitForChild("modules")
local netray: ModuleScript = require(modules_folder:WaitForChild("netray"))

local movement_event: RemoteEvent = netray:GetEvent("movement")

local run_status: boolean = false

local function slide(_, state: Enum.UserInputState, _)

	if state ~= Enum.UserInputState.Begin then return end

	local hrp_velocity: Vector3 = hrp.AssemblyLinearVelocity
	local dir: Vector3 = (Vector3.new(hrp_velocity.X, 0, hrp_velocity.Z)).Unit

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
