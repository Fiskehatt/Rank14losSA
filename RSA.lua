local _G = getfenv(0)
local version = "0.2"
RSA_BUFF = 54
RSA_CAST = 67
RSA_DEBUFF = 83
RSA_FADING = 91
RSA_MENU_TEXT = { "Enabled", "Enabled outside of Battlegrounds", }
RSA_MENU_SETS = { "enabled", "outside", }
RSA_MENU_WHITE = {}
RSA_MENU_WHITE[1] = true
RSA_SOUND_OPTION_NOBUTTON = {}
RSA_SOUND_OPTION_NOBUTTON[RSA_BUFF] = true
RSA_SOUND_OPTION_NOBUTTON[RSA_CAST] = true
RSA_SOUND_OPTION_NOBUTTON[RSA_DEBUFF] = true
RSA_SOUND_OPTION_NOBUTTON[RSA_FADING] = true
RSA_SOUND_OPTION_WHITE = {}
RSA_SOUND_OPTION_WHITE[1] = true
RSA_SOUND_OPTION_WHITE[RSA_BUFF + 1] = true
RSA_SOUND_OPTION_WHITE[RSA_CAST + 1] = true
RSA_SOUND_OPTION_WHITE[RSA_DEBUFF + 1] = true
RSA_SOUND_OPTION_WHITE[RSA_FADING + 1] = true
RSA_SOUND_OPTION_TEXT = {
	"When an enemy recieves a buff:",
	"Adrenaline Rush",
	"Arcane Power",
	"Barkskin",
	"Battle Stance",
	"Berserker Rage",
	"Berserker Stance",
	"Bestial Wrath",
	"Blade Flurry",
	"Blessing of Freedom",
	"Blessing of Protection",
	"Cannibalize",
	"Cold Blood",
	"Combustion",
	"Dash",
	"Death Wish",
	"Defensive Stance",
	"Desperate Prayer",
	"Deterrence",
	"Divine Favor",
	"Divine Shield",
	"Earthbind Totem",
	"Elemental Mastery",
	"Evasion",
	"Evocation",
	"Fear Ward",
	"First Aid",
	"Frenzied Regeneration",
	"Freezing Trap",
	"Grounding Totem",
	"Ice Block",
	"Inner Focus",
	"Innervate",
	"Intimidation",
	"Last Stand",
	"Mana Tide Totem",
	"Nature's Grasp",
	"Nature's Swiftness",
	"Power Infusion",
	"Presence of Mind",
	"Rapid Fire",
	"Recklessness",
	"Reflector",
	"Retaliation",
	"Sacrifice",
	"Shield Wall",
	"Sprint",
	"Stone form",
	"Sweeping Strikes",
	"Tranquility",
	"Tremor Totem",
	"Trinket",
	"Will of the Forsaken",
	"",
	"When an enemy starts casting:",
	"Entangling Roots",
	"Escape Artist",
	"Fear",
	"Hearthstone",
	"Hibernate",
	"Howl of Terror",
	"Mind Control",
	"Polymorph",
	"Revive Pet",
	"Scare Beast",
	"War Stomp",
	"",
	"When a friendly player recieves a debuff:",
	"Blind",
	"Concussion Blow",
	"Counterspell - Silenced",
	"Death Coil",
	"Disarm",
	"Hammer of Justice",
	"Intimidating Shout",
	"Psychic Scream",
	"Repetance",
	"Scatter Shot",
	"Seduction",
	"Silence",
	"Spell Lock",
	"Wyvern Sting",
	"",
	"When a buff fades:",
	"Blessing of Protection",
	"Deterrence",
	"Divine Shield",
	"Evasion",
	"Ice Block",
	"Shield Wall",
	"",
	"When an enemy uses an ability:",
	"Kick",
}


local function print(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg)
end

local function stringToTable(str)
	str = string.sub(str, 1, string.len(str) - 1)
	local args = {}
	for word in string.gfind(str, "[^%s]+") do
		table.insert(args, word)
	end
	return args
end

function RSA_SlashCmdHandler(msg)
	RSAMenuFrame_Toggle()
end

function RSA_OnLoad()
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
end

function RSA_OnEvent(event)
	if event == "PLAYER_ENTERING_WORLD" then
		this:UnregisterEvent("PLAYER_ENTERING_WORLD")
		if not RSAConfig or not RSAConfig.version or RSAConfig.version ~= version then
			RSAConfig = {
				["enabled"] = true,
				["outside"] = true,
				["version"] = "0.1",
				["buffs"] = {
					["enabled"] = true,
					["AdrenalineRush"] = true,
					["ArcanePower"] = true,
					["Barkskin"] = true,
					["BattleStance"] = false,
					["BerserkerRage"] = true,
					["BerserkerStance"] = false,
					["BestialWrath"] = true,
					["BladeFlurry"] = true,
					["BlessingofFreedom"] = true,
					["BlessingofProtection"] = true,
					["Cannibalize"] = true,
					["ColdBlood"] = true,
					["Combustion"] = true,
					["Dash"] = true,
					["DeathWish"] = true,
					["DefensiveStance"] = false,
					["DesperatePrayer"] = true,
					["Deterrence"] = true,
					["DivineFavor"] = true,
					["DivineShield"] = true,
					["EarthbindTotem"] = true,
					["ElementalMastery"] = true,
					["Evasion"] = true,
					["Evocation"] = true,
					["FearWard"] = true,
					["FirstAid"] = true,
					["FrenziedRegeneration"] = true,
					["FreezingTrap"] = true,
					["GroundingTotem"] = true,
					["IceBlock"] = true,
					["InnerFocus"] = true,
					["Innervate"] = true,
					["Intimidation"] = true,
					["LastStand"] = true,
					["ManaTideTotem"] = true,
					["Nature'sGrasp"] = true,
					["Nature'sSwiftness"] = true,
					["PowerInfusion"] = true,
					["PresenceofMind"] = true,
					["RapidFire"] = true,
					["Recklessness"] = true,
					["Reflector"]= true,
					["Retaliation"] = true,
					["Sacrifice"] = true,
					["ShieldWall"] = true,
					["Sprint"] = true,
					["Stoneform"] = true,
					["SweepingStrikes"] = true,
					["Tranquility"] = true,
					["TremorTotem"] = true,
					["Trinket"] = true,
					["WilloftheForsaken"] = true,
				},
				["casts"] = {
					["enabled"] = true,
					["EntanglingRoots"] = true,
					["EscapeArtist"] = true,
					["Fear"] = true,
					["Hearthstone"] = true,
					["Hibernate"] = true,
					["HowlofTerror"] = true,
					["MindControl"] = true,
					["Polymorph"] = true,
					["RevivePet"] = true,
					["ScareBeast"] = true,
					["WarStomp"] = true,
				},
				["debuffs"] = {
					["enabled"] = true,
					["Blind"] = true,
					["ConcussionBlow"] = true,
					["Counterspell-Silenced"] = true,
					["DeathCoil"] = true,
					["Disarm"] = true,
					["HammerofJustice"] = true,
					["IntimidatingShout"] = true,
					["PsychicScream"] = true,
					["Repetance"] = true,
					["ScatterShot"] = true,
					["Seduction"] = true,
					["Silence"] = true,
					["SpellLock"] = true,
					["WyvernSting"] = true,
				},
				["fadingBuffs"] = {
					["enabled"] = true,
					["BlessingofProtection"] = true,
					["Deterrence"] = true,
					["DivineShield"] = true,
					["Evasion"] = true,
					["IceBlock"] = true,
					["ShieldWall"] = true,
				},
				["use"] = {
					["enabled"] = true,
					["Kick"] = true,
				},
			}
		end
		if RSAConfig.enabled then
			if not RSAConfig.outside then
				this:RegisterEvent("ZONE_CHANGED_NEW_AREA")
				RSA_UpdateState()
			else
				RSA_Enable()
			end
		end
		SlashCmdList["RSA"] = RSA_SlashCmdHandler
		SLASH_RSA1 = "/rsa"
	elseif event == "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF" then
		if string.find(arg1, "begins to cast") or string.find(arg1, "begins to perform") then
			RSA_FilterCasts(arg1)
		else
			RSA_FilterBuffs(arg1)
		end
	elseif event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE" then
		if string.find(arg1, "begins to cast") or string.find(arg1, "begins to perform") then
			RSA_FilterCasts(arg1)
		elseif string.find(arg1, "hits") or string.find(arg1, "crits") then
			RSA_FilterAttacks(arg1)
		end
	elseif event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS" then
		RSA_FilterBuffs(arg1)
	elseif event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" then
		RSA_FilterDebuffs(arg1)
	elseif event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" then
		RSA_FilterDebuffs(arg1)
	elseif event == "CHAT_MSG_SPELL_AURA_GONE_OTHER" then
		RSA_FilterFadingBuffs(arg1)
	elseif event == "ZONE_CHANGED_NEW_AREA" then
		RSA_UpdateState()
	end
end

function RSA_UpdateState()
	if GetRealZoneText() == "Alterac Valley" or GetRealZoneText() == "Arathi Basin" or GetRealZoneText() == "Warsong Gulch" then
		RSA_Enable()
	else
		RSA_Disable()
	end
end

function RSA_Disable()
	RSAMenuFrame:UnregisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF")
	RSAMenuFrame:UnregisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE")
	RSAMenuFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE")
	RSAMenuFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE")
	RSAMenuFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS")
	RSAMenuFrame:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER")
end

function RSA_Enable()
	RSAMenuFrame:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF")
	RSAMenuFrame:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE")
	RSAMenuFrame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE")
	RSAMenuFrame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE")
	RSAMenuFrame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS")
	RSAMenuFrame:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER")
end

function RSA_FilterAttacks(msg)
	if not RSAConfig.use.enabled then return end
	local t = stringToTable(msg)
	local spell = t[2]
	local i = 3
	while i < table.getn(t) - 3 do
		spell = spell..t[i]
		i = i + 1
	end
	if RSAConfig.use[spell] then
		RSA_PlaySoundFile(spell)
	end
end

function RSA_FilterBuffs(msg)
	if not RSAConfig.buffs.enabled then return end
	local t = stringToTable(msg)
	local spell = t[3]
	local i = 4
	while t[i] do
		spell = spell..t[i]
		i = i + 1
	end
	if RSAConfig.buffs[spell] then
		RSA_PlaySoundFile(spell)
	elseif RSAConfig.buffs.Trinket and string.find(spell, "Immune") then
		RSA_PlaySoundFile("Trinket")
	elseif RSAConfig.buffs.Reflector and string.find(spell, "Reflector") then
		RSA_PlaySoundFile("Reflector")
	end
end

function RSA_FilterCasts(msg)
	if not RSAConfig.casts.enabled then return end
	local t = stringToTable(msg)
	local spell = t[5]
	local i = 6
	while t[i] do
		spell = spell..t[i]
		i = i + 1
	end
	if RSAConfig.casts[spell] then
		RSA_PlaySoundFile(spell)
	elseif RSAConfig.casts.Polymorph and string.find(spell, "Polymorph") then
		RSA_PlaySoundFile("Polymorph")
	end
end

function RSA_FilterDebuffs(msg)
	if not RSAConfig.debuffs.enabled then return end
	local t = stringToTable(msg)
	local spell = t[5]
	local i = 6
	while t[i] do
		spell = spell..t[i]
		i = i + 1
	end
	if RSAConfig.debuffs[spell] then
		RSA_PlaySoundFile(spell)
	end
end

function RSA_FilterFadingBuffs(msg)
	if not RSAConfig.fadingBuffs.enabled then return end
	local t = stringToTable(msg)
	local spell = t[1]
	local i = 2
	while i < table.getn(t) - 2 do
		spell = spell..t[i]
		i = i + 1
	end
	if RSAConfig.fadingBuffs[spell] then
		RSA_PlaySoundFile(spell.."down")
	end
end

function RSA_PlaySoundFile(spell)
	PlaySoundFile("Interface\\AddOns\\Rank14losSA\\Voice\\"..spell..".ogg", "Master")
end

function RSA_Subtable(index)
	if index < RSA_BUFF then
		return "buffs"
	elseif index < RSA_CAST then
		return "casts"
	elseif index < RSA_DEBUFF then
		return "debuffs"
	elseif index < RSA_FADING then
		return "fadingBuffs"
	else
		return "use"
	end
end

function RSA_SoundText(index)
	if RSA_SOUND_OPTION_WHITE[index] then
		return "enabled" 
	else
		return string.gsub(RSA_SOUND_OPTION_TEXT[index], " ", "")
	end
end

function RSACheckButton_OnClick()
	if this.variable then
		if this:GetChecked() then
			RSAConfig[this.variable] = true
		else
			RSAConfig[this.variable] = false
		end
		if this.index == 1 then
			RSAMenuFrame_UpdateDependencies()
			if RSAConfig.outside and this:GetChecked() then
				RSA_Enable()
			else
				RSA_Disable()
			end
		else
			if this:GetChecked() then
				RSAMenuFrame:UnregisterEvent("ZONE_CHANGED_NEW_AREA")
				RSA_Enable()
			else
				RSAMenuFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
				RSA_UpdateState()
			end
		end
	else
		if this:GetChecked() then
			RSAConfig[RSA_Subtable(this.index)][RSA_SoundText(this.index)] = true
		else
			RSAConfig[RSA_Subtable(this.index)][RSA_SoundText(this.index)] = false
		end
		if RSA_SOUND_OPTION_WHITE[this.index] then
			RSASoundOptionFrame_Update()
		end
	end
end

function RSAMenuFrame_Toggle()
	if RSAMenuFrame:IsVisible() then
		RSAMenuFrame:Hide()
	else
		RSAMenuFrame:Show()
	end
end

function RSAMenuFrame_Update()
	local button, fontString
	for i=1,2 do
		fontString = _G["RSAMenuFrameButton"..i.."Text"]
		fontString:SetText(RSA_MENU_TEXT[i])
		button = _G["RSAMenuFrameButton"..i]
		button.variable = RSA_MENU_SETS[i]
		button.index = i
		button:SetChecked(RSAConfig[button.variable])
		if RSA_MENU_WHITE[i] then
			fontString:SetTextColor(1,1,1)
		end
	end
	RSAMenuFrame_UpdateDependencies()
end

function RSAMenuFrame_UpdateDependencies()
	if RSAConfig.enabled then
		OptionsFrame_EnableCheckBox(RSAMenuFrameButton2)
	else
		OptionsFrame_DisableCheckBox(RSAMenuFrameButton2)
	end
end

function RSASoundOptionFrame_Toggle()
	if RSASoundOptionFrame:IsVisible() then
		RSASoundOptionFrame:Hide()
	else
		RSASoundOptionFrame:Show()
	end
end

function RSASoundOptionFrame_Update()
	local button, fontString
	local offset = FauxScrollFrame_GetOffset(RSASoundOptionFrameScrollFrame)
	for i=1,17 do
		index = offset + i
		fontString = _G["RSASoundOptionFrameButton"..i.."Text"]
		fontString:SetText(RSA_SOUND_OPTION_TEXT[index])
		
		button = _G["RSASoundOptionFrameButton"..i]
		button.index = index
		
		if RSA_SOUND_OPTION_NOBUTTON[index] then
			button:Hide()
		else
			button:Show()
			button:SetChecked(RSAConfig[RSA_Subtable(index)][RSA_SoundText(index)])
		end
		
		if RSA_SOUND_OPTION_WHITE[index] then
			OptionsFrame_EnableCheckBox(button)
			fontString:SetTextColor(1,1,1)
		else
			if RSAConfig[RSA_Subtable(index)]["enabled"] then
				OptionsFrame_EnableCheckBox(button)
			else
				OptionsFrame_DisableCheckBox(button)
			end
		end
	end
	
	FauxScrollFrame_Update(RSASoundOptionFrameScrollFrame, table.getn(RSA_SOUND_OPTION_TEXT), 17, 16)
end