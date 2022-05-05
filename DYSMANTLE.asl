
state("DYSMANTLE", "1.0.2")
{
	int chunkId : "prog.dll", 0x005EA868, 0x00, 0x18C;
	uint titleEndValue : "prog.dll", 0x005EA868, 0x00, 0x198;
	float playerX : "prog.dll", 0x005DAE28;
	float playerY : "prog.dll", 0x005DAE2C;
	
	int numCampfires : "prog.dll", 0x005DAC10, 0x190, 0x50, 0x8C;
	int numTowers : "prog.dll", 0x005DAC10, 0x190, 0x58, 0x8C;
	int numTombs : "prog.dll", 0x005DAC10, 0x190, 0x88, 0x8C;
	
	bool isPlaying : "DYSMANTLE.exe", 0x22F018;
}

state("DYSMANTLE", "1.0.3")
{
	int chunkId : "prog.dll", 0x0060CE98, 0x00, 0x18C;
	uint titleEndValue : "prog.dll", 0x0060CE98, 0x00, 0x198;
	float playerX : "prog.dll", 0x005DAE28;  //fix
	float playerY : "prog.dll", 0x005DAE2C;  //fix
	
	int numCampfires : "prog.dll", 0x005FCFB8, 0x190, 0x50, 0x8C;
	int numTowers : "prog.dll", 0x005FCFB8, 0x190, 0x58, 0x8C;
	int numTombs : "prog.dll", 0x005FCFB8, 0x190, 0x88, 0x8C;
	
	bool isPlaying : "DYSMANTLE.exe", 0x22F018;
}

init
{
	print("Module size: " + modules.First().ModuleMemorySize.ToString());
	
	ProcessModuleCollection col = game.Modules;
	print("Modules amount: " + col.Count.ToString());
	
    /*
	if (modules.First().ModuleMemorySize == 0x01)
        version = "1.0.2";
    else if (modules.First().ModuleMemorySize == 0x02)
        version = "1.0.3";
	else
		version = "Unknown";
	*/
	version = "1.0.2";
}

startup 
{
	vars.lastValidChunkId = 0;
	
	vars.towerValues = new Dictionary<int, string>()
	{
		{ 0xA05, "Capernaum" },
		{ 0xA10, "Canaveral" },
		{ 0x7C7, "Fairwood" },
		{ 0xBE5, "Hedgefield" },
		{ 0xB14, "Narrows Vale" },
		{ 0x801, "Central" },
		{ 0x851, "Westport" },
		{ 0x7AC, "Crown" },
		{ 0xB47, "Vulcan" },
		{ 0xEED, "Everglade" },
		{ 0xC20, "Sunburn Desert" },
		{ 0xD90, "Solaris" },
		{ 0xFFA, "Serpent's Crossing" },
		{ 0x405, "Borealis" },
		{ 0x413, "Arcturus" },
		{ 0x456, "Hibernus" },
		{ 0x3EA, "Frore" },
		{ 0x25C, "Polaris" },
		{ 0x189, "Frost Horn" }
	};
	print("Initialized " + vars.towerValues.Count.ToString() + " towers.");
	
	vars.tombValues = new Dictionary<int, string>()
	{
		{ 0x9A2, "Capernaum" },
		{ 0xA0B, "Canaveral" },
		{ 0x63B, "Fairwood" },
		{ 0xBE0, "Hedgefield" },
		{ 0xAAE, "Narrows Vale" },
		{ 0x97C, "Central" },
		{ 0x799, "Westport" },
		{ 0x86D, "Crown" },
		{ 0x8A7, "Vulcan" },
		{ 0x1071, "Everglade" },
		{ 0xF20, "Sunburn Desert" },
		{ 0xF06, "Solaris" },
		{ 0xF93, "Serpent's Crossing" },
		{ 0x587, "Borealis" },
		{ 0x3B2, "Arcturus" },
		{ 0x4B8, "Hibernus" },
		{ 0x5CD, "Frore" },
		{ 0x3E4, "Polaris" },
		{ 0x60D, "Frost Horn Lower" },
		{ 0x2A8, "Frost Horn Upper" }
	};
	print("Initialized " + vars.tombValues.Count.ToString() + " tombs.");
	
	//Obelisks SC - 0x105E, W - 0x671, F - 0x696
	
	vars.campfireValues = new Dictionary<int, string>()
	{
	//Capernaum
		{ 0xA62, "Home Shelter" },
		{ 0xA04, "Home Suburb" },
		{ 0x9A7, "Suburb Truck Yard" },
	//Canaveral
		{ 0xA0E, "Evac Site Entrance" },
		{ 0xA10, "Aerospace Center Inner Courtyard" },
		{ 0x8EA, "Packard Family Farm" },
		{ 0xB2D, "Bowel Lake Camping Grounds" }, //2
	//Fairwood
		{ 0x886, "Lone Field" },
		{ 0x8E1, "Lakeside Shack" },
		{ 0x7C5, "Large House" },
		{ 0x701, "Twin Lakes" },
		{ 0x75E, "Wayward Storage Yard" },
		{ 0x769, "Armando's Used Cars" },
		{ 0x5E4, "Ruins of Ethelridge" }, //2
		{ 0x64C, "Curtisfield North" },
	//Hedgefield
		{ 0xB8A, "Southern Cemetery" },
		{ 0xBE5, "Southern Power Station" },
		{ 0xBE0, "Greyhaven" },
		{ 0xD64, "Everglade Bay" },
	//Narrows Vale
		{ 0xC9A, "Blue Ponds Motel" },
		{ 0xC36, "Underfield" },
		{ 0xB16, "Fincher's Auto Salvage" },
		{ 0xC92, "Brook Bridge Campfire" },
		{ 0xB72, "Sanctuary Farm Campsite" }, //2
		{ 0xB0C, "West Cutter Campfire" },
	//Borealis
		{ 0x461, "Little Otter" },
		{ 0x33D, "Wilderness Cabin" },
		{ 0x404, "Northeast Power Station" },
		{ 0x2E6, "Corrective Facility" },
		{ 0x287, "Prison Back Yard" },
	//Arcturus
		{ 0x46B, "Northern Checkpoint" },
		{ 0x413, "Beaver Point" },
		{ 0x478, "Borealis Traveller Lodge" },
	//Everglade
		{ 0xD70, "Ft. Darrow" },
		{ 0xDCA, "Gheens" },
		{ 0xEED, "Overgrown Depot" },
		{ 0x1013, "Southern Tip" }, //2
		{ 0xE95, "Holiday Resort" },
	//Sunburn Desert
		{ 0xC29, "Pimaville Outskirts" }, //2
		{ 0xAA2, "Dried Out Farm" },
		{ 0xE64, "Driftwood" },
		{ 0xC81, "Diamond Mine" },
		{ 0xD9C, "Mansion Entrance" },
		{ 0xECC, "South of Fool's Canyon" },
	//Central
		{ 0x9E8, "Southern Central Office Building" },
		{ 0x923, "Destroyed Building" },
		{ 0x7A1, "Mail Loading Bay" },
		{ 0x806, "Pioneer's Park" },
		{ 0x748, "Eastern Central City Suburbs" }, //2
		{ 0x6E5, "Mountainside Suburb" }, //3
		{ 0x683, "Drive-in Theater" }, //2
		{ 0x6DE, "Football Stadium Outskirts" },
		{ 0x8BD, "Heavy Industry Zone" },
	//Westport
		{ 0x856, "Lawrence Farm" },
		{ 0x7F1, "Westport Harbor" },
		{ 0x675, "Log Mansion" },
		{ 0x798, "Westport Clifftop Tomb" },
	//Solaris
		{ 0xA98, "Desert Truck Stop Campfire" }, //2
		{ 0xC79, "Solaris Farm Campfire" },
		{ 0xB4E, "Solaris Train Station Campfire" },
		{ 0xCCF, "Military Road Campfire" },
		{ 0xF6F, "Military Base South Campfire" },
		{ 0xE49, "Military Airfield Campfire" },
		{ 0xF0B, "Mercury Installation Campfire" },
	//Hibernus
		{ 0x758, "Hibernus Rest Stop" },
		{ 0x4B4, "Krebbs' Wood & Timber" },
		{ 0x398, "Hibernus Homestead" },
	//Undercrown
		{ 0x6F5, "Tunnel East Entrance" },
		{ 0x810, "Old Mines Campfire (Don't Use)" },
		{ 0x6EE, "Tunnel West Entrance Campfire" },
		{ 0x692, "Elevator Bridge Campfire" },
	//Frore
		{ 0x390, "Chalice Outskirts" },
		{ 0x20B, "Lone Log Cabin" },
		{ 0x3EB, "Naval Base Entrance" },
		{ 0x4AB, "The Ark Entrance" },
		{ 0x4AF, "Badnews Bay" },
		{ 0x5C9, "Southern Frore Roadhouse" },
	//Serpent's Crossing
		{ 0xF8F, "Expedition Basecamp" },
		{ 0xFF6, "Temple Pass" },
		{ 0xE15, "Vine Ravine" },
		{ 0x105B, "Beachhead Station" },
		{ 0x105F, "Mountain Path Entrance" },
		{ 0xEDF, "Volcano Mouth" },
		{ 0xF3F, "Volcano Mouth Temple" },
	//Vulcan
		{ 0xA89, "Near Vulcan Ancient Ruins" },
		{ 0x966, "By the Toxic Pools" },
		{ 0x90A, "Beach Party" },
		{ 0x8A5, "Land's End" },
		{ 0x847, "Caldera" }, //2
	//Polaris
		{ 0x55B, "Polaris Checkpoint Campfire" },
		{ 0x378, "Wellspring Station Campfire" },
		{ 0x2B6, "North Star Installation Campfire" },
		( 0x2BE, "Icy Bridge Campfire" },
		{ 0x4A2, "Polaris Wilderness Campfire" }, //2
	//Frost Horn
		{ 0x492, "Lower Pumping Station" },
		{ 0x2AB, "Arctic Research Base" },
		{ 0x4E9, "Near the Survivor Island" },
		{ 0x2A6, "Outside Arcadia" },
		{ 0x48B, "Hydroelectric Dam" },
	//Crown
		{ 0x751, "Crown Station Entrance" },
		{ 0x810, "Crown Station Center (Don't Use)" },
		{ 0x92C, "The Fortress Campfire" },
		{ 0x8D1, "Crown Station Overpass" }
	};
	
	Dictionary<int, string> campfireRegions = new Dictionary<int, string>()
	{
		{ 0, "Capernaum" },
		{ 3, "Canaveral" },
		{ 7, "Fairwood" },
		{ 14, "Hedgefield" },
		{ 18, "Narrows Vale" }
	};
	print("Initialized " + vars.campfireValues.Count.ToString() + " campfires.");
	
	settings.Add("escapePod", true, "Escape Pod");
	settings.Add("towers", true, "Towers");
	settings.Add("tombs", true, "Tombs");
	settings.Add("campfires", true, "Campfires");
	settings.Add("bosses", true, "Bosses");	
	
	//Tower settings
	
	settings.CurrentDefaultParent = "towers";
	foreach (string tower in vars.towerValues.Values)
	{
		settings.Add(tower + "_Tower", false, tower);
	}
	
	//Tomb settings
	
	settings.CurrentDefaultParent = "tombs";
	foreach (string tomb in vars.tombValues.Values)
	{
		settings.Add(tomb + "_Tomb", false, tomb);
	}
	
	//Campfire settings
	
	byte currIdx = 0;
	foreach (string campfire in vars.campfireValues.Values)
	{
		if (campfireRegions.ContainsKey(currIdx))
		{
			settings.Add(campfireRegions[currIdx] + "_Fires", true, campfireRegions[currIdx], "campfires");
			settings.CurrentDefaultParent = campfireRegions[currIdx] + "_Fires";
		}
		settings.Add(campfire, false, campfire);
		currIdx++;
	}
	
	//Multi chunk splits
	vars.towerValues.Add(0xDF0, "Solaris");
	vars.campfireValues.Add(0x9A4, "Home Suburb");
	vars.campfireValues.Add(0xB8D, "Bowel Lake Camping Grounds");
	vars.campfireValues.Add(0x5E5, "Ruins of Ethelridge");
	vars.campfireValues.Add(0x2E7, "Corrective Facility");
	vars.campfireValues.Add(0x4CB, "Northern Checkpoint");
	vars.campfireValues.Add(0x1073, "Southern Tip");
	vars.campfireValues.Add(0xB73, "Sanctuary Farm Campsite");
	vars.campfireValues.Add(0xC2A, "Pimaville Outskirts");
	vars.campfireValues.Add(0x749, "Eastern Central City Suburbs");
	vars.campfireValues.Add(0x6E6, "Mountainside Suburb");
	vars.campfireValues.Add(0x745, "Mountainside Suburb");
	vars.campfireValues.Add(0x684, "Drive-in Theater");
	vars.campfireValues.Add(0xA99, "Desert Truck Stop Campfire");
	vars.campfireValues.Add(0x848, "Caldera");
	vars.campfireValues.Add(0x379, "Wellspring Station Campfire");
	vars.campfireValues.Add(0x502, "Polaris Wilderness Campfire");
	vars.campfireValues.Add(0x2A7, "Outside Arcadia");
	
	//Boss settings
	
	settings.CurrentDefaultParent = "bosses";
}

start
{
	return current.titleEndValue == 259 && (old.titleEndValue == 0 || old.titleEndValue == uint.MaxValue);
}

split
{
	if (current.chunkId != 0)
		vars.lastValidChunkId = current.chunkId;
		
	bool tower = current.numTowers == old.numTowers + 1 && vars.towerValues.ContainsKey(current.chunkId) && settings[vars.towerValues[current.chunkId] + "_Tower"];
	bool tomb = current.numTombs == old.numTombs + 1 && vars.tombValues.ContainsKey(vars.lastValidChunkId) && settings[vars.tombValues[vars.lastValidChunkId] + "_Tomb"];
	bool campfire = current.numCampfires == old.numCampfires + 1 && vars.campfireValues.ContainsKey(current.chunkId) && settings[vars.campfireValues[current.chunkId]];	
	bool escapePod = settings["escapePod"] && current.playerX == 62071 && current.playerY == 30930 && current.titleEndValue == uint.MaxValue && old.titleEndValue != uint.MaxValue;
	
	return tower || tomb || campfire || escapePod;
}

isLoading
{
	return !current.isPlaying;
}