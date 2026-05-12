--!strict

local ps = game:GetService("Players") :: Players
local ts = game:GetService("TweenService") :: TweenService
local uis = game:GetService("UserInputService") :: UserInputService

local p = ps.LocalPlayer :: Player
local ch: Model = p.Character or p.CharacterAdded:Wait()
local hrp = ch:WaitForChild("HumanoidRootPart") :: BasePart
local lw_torso = ch:WaitForChild("LowerTorso") :: Part

local root = Instance.new("Motor6D") :: Motor6D

root.Name = "freaky_root"
root.Part0 = hrp
root.Part1 = lw_torso
root.Parent = lw_torso

local origin_rot = root.C0 :: CFrame

local left_rot = origin_rot * CFrame.Angles(0, 0, math.rad(15)) :: CFrame
local right_rot = origin_rot * CFrame.Angles(0, 0, math.rad(-15)) :: CFrame

local tinfo = TweenInfo.new(.2) :: TweenInfo

type key_list = {Enum.KeyCode}

local default_keys: key_list = {

	Enum.KeyCode.A,
	Enum.KeyCode.D
}

uis.InputBegan:Connect(function(input: InputObject, gp: boolean)

	if gp then return end

	local any_key_down = false :: boolean

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

	local amount_of_left_keys = 0 :: number

	for _, key: Enum.KeyCode in pairs(default_keys) do

		if not uis:IsKeyDown(key) then

			amount_of_left_keys += 1
		end
	end

	if amount_of_left_keys ~= #default_keys then return end

	ts:Create(root, tinfo, {C0 = origin_rot}):Play()
end)
