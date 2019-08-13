--[[
	Demojify.lua
	A function to strip emoji-like codepoints from strings.
  
	This module is licensed under MIT, review the LICENSE file or:
	https://github.com/buildthomas/Demojify/blob/master/LICENSE
--]]

local function Lookupify(Array)
	local Result = {}
	for _, Value in ipairs(Array) do
		Result[Value] = true
	end
	return Result
end

local BLOCKED_RANGES = {
	{0x0001F601, 0x0001F64F};
	{0x00002702, 0x000027B0};
	{0x0001F680, 0x0001F6C0};
	{0x000024C2, 0x0001F251};
	{0x0001F300, 0x0001F5FF};
	{0x00002194, 0x00002199};
	{0x000023E9, 0x000023F3};
	{0x000025FB, 0x000026FD};
	{0x0001F300, 0x0001F5FF};
	{0x0001F600, 0x0001F636};
	{0x0001F681, 0x0001F6C5};
	{0x0001F30D, 0x0001F567};
}

local BLOCKED_SINGLES = Lookupify{
	0x000000A9;
	0x000000AE;
	0x0000203C;
	0x00002049;
	0x000020E3;
	0x00002122;
	0x00002139;
	0x000021A9;
	0x000021AA;
	0x0000231A;
	0x0000231B;
	0x000025AA;
	0x000025AB;
	0x000025B6;
	0x000025C0;
	0x00002934;
	0x00002935;
	0x00002B05;
	0x00002B06;
	0x00002B07;
	0x00002B1B;
	0x00002B1C;
	0x00002B50;
	0x00002B55;
	0x00003030;
	0x0000303D;
	0x00003297;
	0x00003299;
	0x0001F004;
	0x0001F0CF;
}

--[[**
	Strip emoji-like codepoints from strings for use in Roblox and analytics.
	@param [string] String The string you want to remove emjois from.
	@returns [string] The safe string.
**--]]
local function Demojify(String)
	-- Array that will contain non-emoji codepoints in string
	local Codepoints = {}
	local Length = 0

	-- Loop over codepoints in input
	for _, Codepoint in utf8.codes(String) do
		-- Assume innocent until proven guilty
		local Insert = true

		-- Check if singular blocked
		if BLOCKED_SINGLES[Codepoint] then
			Insert = false
		else
			-- Check all ranges
			for _, Range in ipairs(BLOCKED_RANGES) do
				if Range[1] <= Codepoint and Codepoint <= Range[2] then
					-- Codepoint is in an emoji range
					Insert = false
					break
				end
			end
		end

		-- Only insert into table if proven non-emoji
		if Insert then
			Length = Length + 1
			Codepoints[Length] = Codepoint
		end
	end

	-- Return string without emoji codepoints
	return utf8.char(table.unpack(Codepoints, 1, Length))
end

return Demojify
