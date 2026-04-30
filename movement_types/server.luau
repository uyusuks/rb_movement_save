local rs = game:GetService("ReplicatedStorage")

local modules_folder = rs:WaitForChild("modules")
local netray = require(modules_folder:WaitForChild("netray"))

local movement_event = netray:RegisterEvent("movement")

local movement_save = {}

movement_event:OnEvent(function(p, data)

    local ch = p.Character or p.CharacterAdded:Wait()
    local hrp = ch:WaitForChild("HumanoidRootPart")
    local hmd = ch:WaitForChild("Humanoid")

    if data.movement_type == "run" then
        
       if data.run_status then
        
            hmd.WalkSpeed = movement_save[p.Name .. "_ws"]
       else

            movement_save[p.Name .. "_ws"] = hmd.WalkSpeed

			hmd.WalkSpeed += 15
       end

    elseif data.movement_type == "slide" then

        local dir = data.dir

        if dir.Magnitude == math.huge or dir.Magnitude ~= dir.Magnitude then return end

        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(4e4, 0, 4e4)
        bv.Velocity = 60 * dir
        
        bv.Parent = hrp

        task.delay(.3, function()
            
            bv:Destroy()
        end)
    end
end)
