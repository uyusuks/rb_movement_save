--!nonstrict

local rs: ReplicatedStorage = game:GetService("ReplicatedStorage")

local modules_folder: Folder = rs:WaitForChild("modules")
local netray: ModuleScript = require(modules_folder:WaitForChild("netray"))

local movement_event: RemoteEvent = netray:RegisterEvent("movement")

local movement_save = {}

movement_event:OnEvent(function(p: Player, data)

	local ch: Model = p.Character or p.CharacterAdded:Wait()
	local hrp: BasePart = ch:WaitForChild("HumanoidRootPart")
	local hmd: Humanoid = ch:WaitForChild("Humanoid")

	if data.movement_type == "run" then

		if data.run_status then

			hmd.WalkSpeed = movement_save[p.Name .. "_ws"]
		else

			movement_save[p.Name .. "_ws"] = hmd.WalkSpeed

			hmd.WalkSpeed += 15
		end

	elseif data.movement_type == "slide" then

		local dir: Vector3 = data.dir

		if dir.Magnitude == math.huge or dir.Magnitude ~= dir.Magnitude then return end

		local bv: BodyVelocity = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(4e4, 0, 4e4)
		bv.Velocity = 60 * dir

		bv.Parent = hrp

		task.delay(.3, function()

			bv:Destroy()
		end)
	end
end)
