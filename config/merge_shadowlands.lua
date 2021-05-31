--[[   ____    ______
      /\  _`\ /\__  _\   __
 __  _\ \ \/\_\/_/\ \/ /_\ \___
/\ \/'\\ \ \/_/_ \ \ \/\___  __\
\/>  </ \ \ \L\ \ \ \ \/__/\_\_/
 /\_/\_\ \ \____/  \ \_\  \/_/
 \//\/_/  \/___/    \/_/

 [=====================================]
 [  Author: Dandraffbal-Stormreaver US ]
 [  xCT+ Version 4.x.x                 ]
 [  ©2020. All Rights Reserved.        ]
 [====================================]]

local ADDON_NAME, addon = ...

-- New way of doing merge items
-- 'alias' takes the original spell id and a replacement spell id
-- item takes a item id, the merge interval in seconds, and a helpful description of the item
-- header switches the header for the next set of items
local _, _, _, alias, item, header = unpack(addon.merge_helpers)

--[[header "|cffd2d3d8SL|r™ |cff798BDDTemplates|r"
do
end

header "|cffd2d3d8SL|r™ |cff798BDDConsumables|r"
do
end

header "|cffd2d3d8SL|r™ |cff798BDDItems|r"
do
end

header "|cffd2d3d8SL|r™ |cff798BDDWorld Zones|r"
do
end

header "|cffd2d3d8SL|r™ |cff798BDDQuest Items|r"
do
end
--]]
header "|cffd2d3d8ShadowLands|r™ |cff798BDDCovenants|r"
do
	-- Venthyr
	-- warlock
	item '321792' '1.0' "Impending Catastrophe"
	alias '322167' '321792' -- Impending Catastrophe dot
	alias '322170' '321792' -- Impending Catastrophe dot
end

header "|cffd2d3d8ShadowLands|r™ |cff798BDDQuest Spells|r"
do
	-- Ardenweald
	item '343048' '1.0' "Nature's Blessing"
end

header "|cffd2d3d8ShadowLands|r™ |cff798BDDTrinkets|r"
do
	item '180117' '0.5' "Empyreal Ordnance"
	alias '344540' '180117' -- Empyreal Ordnance dot
	
	item '178769' '1.0' "Infinitely Divisible Ooze"
	alias '345495' '178769' -- Infinitely Divisible Ooze damage
	
	item '178772' '0.5' "Satchel of Misbegotten Minions"
	alias '345638' '178772' -- Satchel of Misbegotten Minions damage
	
	item '184021' '2.0' "Glyph of Assimilation"
	alias '345319' '184021' -- Glyph of Assimilation dot
	
	item '182453' '0.5' "Twilight Bloom"
	alias '339545' '182453' -- Twilight Bloom: Twilight Restoration
end

header "|cffd2d3d8ShadowLands|r™ |cff798BDDLegendaries|r"
do
	-- Priest
	item '336214' '0.5' "Eternal Call to the Void"
	alias '193473' '336214' -- Eternal Call to the Void: Mind Flay
	alias '344752' '336214' -- Eternal Call to the Void: Mind Sear
end

