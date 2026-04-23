-- shippus@ProximityStudios
-- Licensed under the MPL V2.0

-- API & Startup --
local config = script:FindFirstChild("Configuration")

if not config then
	config = Instance.new("Configuration")
	config.Parent = script
	-- Here you can change the values.
	config:SetAttribute("duration_Day", 15) 
	config:SetAttribute("duration_Night", 15)
	config:SetAttribute("hour", 12)
end

-- You can delete everything between these lines if you won't use the API
local api_Daytimecycle = Instance.new("RemoteEvent")
api_Daytimecycle.Parent = game.ReplicatedStorage
api_Daytimecycle.Name = "changeCycle" -- Change the name to another if desired. Though, if you do, you will have to change all references from the old name to the new one.
-- You can delete everything between these lines if you won't use the API

-- Configuration --
local duration_Day = script.Configuration:GetAttribute("duration_Day") -- Duration of day in minutes.
local duration_Night = script.Configuration:GetAttribute("duration_Night") -- Duration of night in minutes.
-- Services --
local lighting = game:GetService("Lighting")

-- Startup --
local hour = script.Configuration:GetAttribute("hour")

-- Detects if attribute values were changed during gameplay
config:GetAttributeChangedSignal("duration_Day"):Connect(function()
	duration_Day = script.Configuration:GetAttribute("duration_Day")
	print("duration_Day variable changed to: " .. tostring(duration_Day))
end)
config:GetAttributeChangedSignal("duration_Night"):Connect(function()
	duration_Night = script.Configuration:GetAttribute("duration_Night")
	print("duration_Night variable changed to: " .. tostring(duration_Night))
end)
config:GetAttributeChangedSignal("hour"):Connect(function()
	local hour = script.Configuration:GetAttribute("hour")
	print("hour variable changed to: " .. tostring(hour))
end)
-- Main --

local function cycle()
	print("Started cycle.")

	while true do
		local totalRealSeconds = (duration_Day + duration_Night) * 60  -- = 1200 seconds
		local rate = 24 / totalRealSeconds           -- = 0.02 clockTime per second
		
		local dt = task.wait()             -- dt = seconds since last frame

		hour = hour + (dt * rate) -- advance the clock
		hour = hour % 24          -- wrap around at midnight

		local hours   = math.floor(hour)
		local minutes = math.floor((hour % 1) * 60)

		print(hours .. "h " .. minutes .. "m")
		lighting.ClockTime = hour
	end
end

cycle() -- Calls the function to start the cycle.
