--!nonstrict

local ps: Players = game:GetService("Players")
local ts: TweenService = game:GetService("TweenService")
local uis: UserInputService = game:GetService("UserInputService")

local p: Player? = ps.LocalPlayer
local ch: Model = p.Character or p.CharacterAdded:Wait()
local hrp: BasePart = ch:WaitForChild("HumanoidRootPart")
local lw_torso: BasePart = ch:WaitForChild("LowerTorso")

local root: Motor6D = Instance.new("Motor6D")

root.Name = "freaky_root"
root.Part0 = hrp
root.Part1 = lw_torso
root.Parent = lw_torso

local origin_rot: CFrame = root.C0

local left_rot: CFrame = origin_rot * CFrame.Angles(0, 0, math.rad(15))
local right_rot: CFrame = origin_rot * CFrame.Angles(0, 0, math.rad(-15))

local tinfo: TweenInfo = TweenInfo.new(.2)

type key_list = {Enum.KeyCode}

local default_keys: key_list = {

	Enum.KeyCode.A,
	Enum.KeyCode.D
}

uis.InputBegan:Connect(function(input: InputObject, gp: boolean)

	if gp then return end

	local any_key_down: boolean = false

	for _, key: Enum.KeyCode in pairs(default_keys) do

		if uis:IsKeyDown(key) then

			any_key_down = true

			break
		end
	end

	if not any_key_down then return end

	if uis.MouseBehavior ~= Enum.MouseBehavior.LockCenter then ts:Create(root, tinfo, {C0 = origin_rot}):Play() return end

	if input.KeyCode == Enum.KeyCode.A then

		ts:Create(root, tinfo, {C0 = left_rot}):Play()

	elseif input.KeyCode == Enum.KeyCode.D then

		ts:Create(root, tinfo, {C0 = right_rot}):Play()
	end
end)

uis.InputEnded:Connect(function(_: InputObject, gp: boolean)

	if gp then return end

	local amount_of_left_keys: number = 0

	for _, key: Enum.KeyCode in pairs(default_keys) do

		if not uis:IsKeyDown(key) then

			amount_of_left_keys += 1
		end
	end

	if amount_of_left_keys ~= #default_keys then return end

	ts:Create(root, tinfo, {C0 = origin_rot}):Play()
end)
