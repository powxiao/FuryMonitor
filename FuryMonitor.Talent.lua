--[[
This program is free software. It comes without any warranty, to
the extent permitted by applicable law. You can redistribute it
and/or modify it under the terms of the Do What The Fuck You Want
To Public Liscence, Version 2, as published by Sam Hocevar. See
http://sam.zoy.org/wtfpl/COPYING for more details.
]]--

FuryMonitor.Talent = {};
FuryMonitor.Talent.__index = FuryMonitor.Talent;

function FuryMonitor.Talent:new(name)
	local members = {
		_name = name,
		_rank = 0,
		_loaded = false
	};
	return setmetatable(members, FuryMonitor.Talent);
end

function FuryMonitor.Talent:GetRank()
	self:Load();
	return self._rank;
end

function FuryMonitor.Talent:GetName()
	return self._name;
end

function FuryMonitor.Talent:Load()
	if self._loaded == true then
		return;
	end

	-- Iterate through the tabs and talents until we encounter
	-- the talent with the specified name
	local numTabs = GetNumTalentTabs();
	for tab = 1, numTabs do
		local numTalents = GetNumTalents(tab);
		for talent = 1, numTalents do
			local talentName, _, _, _, talentRank, _, _, _
				= GetTalentInfo(tab, talent);
			
			if talentName == self:GetName() then
				self._rank = talentRank;

				self._loaded = true;
			end	
		end
	end

end

function FuryMonitor.Talent:OnTalentsChanged()
	self._loaded = false;
end
