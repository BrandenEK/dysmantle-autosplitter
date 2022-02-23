//V 1.0.2.10
state("DYSMANTLE")
{
	int chunkId : "prog.dll", 0x005EA868, 0x00, 0x18C;
	uint titleEndValue : "prog.dll", 0x005EA868, 0x00, 0x198;
	float playerX : "prog.dll", 0x005DAE28;
	float playerY : "prog.dll", 0x005DAE2C;
	
	int numCampfires : "prog.dll", 0x005DAC10, 0x190, 0x50, 0x8C;
	int numTowers : "prog.dll", 0x005DAC10, 0x190, 0x58, 0x8C;
	int numTombs : "prog.dll", 0x005DAC10, 0x190, 0x88, 0x8C;
}

startup 
{
	vars.lastValidChunkId = 0;
	
	vars.towerValues = new Dictionary<int, string>()
	{
		{ 2565, "Capernaum" },
		{ 2576, "Canaveral" },
		{ 1991, "Fairwood" },
		{ 3045, "Hedgefield" },
		{ 2836, "Narrows Vale" },
		{ 2049, "Central" },
		{ 2129, "Westport" },
		{ 1964, "Crown" },
		{ 2887, "Vulcan" },
		{ 3821, "Everglade" },
		{ 3104, "Sunburn Desert" },
		{ 3472, "Solaris" },
		{ 4090, "Serpent's Crossing" },
		{ 1029, "Borealis" },
		{ 1043, "Arcturus" },
		{ 1110, "Hibernus" },
		{ 1002, "Frore" },
		{ 604, "Polaris" },
		{ 393, "Frost Horn" }
	};
	print("Initialized " + vars.towerValues.Count.ToString() + " towers.");
	
	vars.campfireValues = new Dictionary<int, string>()
	{
	//Capernaum
		{ 2658, "Home Shelter" },
		{ 2564, "Home Suburb" },
		{ 2471, "Suburb Truck Yard" },
	//Canaveral
		{ 2574, "Evac Site Entrance" },
		{ 2576, "Aerospace Center Inner Courtyard" },
		{ 2282, "Packard Family Farm" },
		{ 2861, "Bowel Lake Camping Grounds" },
	//Fairwood
		{ 2182, "Lone Field" },
		{ 2273, "Lakeside Shack" },
		{ 1989, "Large House" },
		{ 1793, "Twin Lakes" },
		{ 1886, "Wayward Storage Yard" },
		{ 1897, "Armando's Used Cars" },
		{ 1509, "Ruins of Ethelridge" },
	//Hedgefield
		{ 2954, "Southern Cemetery" },
		{ 3045, "Southern Power Station" },
		{ 3040, "Greyhaven" },
		{ 3428, "Everglade Bay" },
	//Narrows Vale
		{ 3226, "Blue Ponds Motel" },
		{ 3126, "Underfield" },
		{ 3218, "Brook Bridge Campfire" },
		{ 2828, "West Cutter Campfire" },
		{ 2930, "Sanctuary Farm Campsite" },
		{ 2838, "Fincher's Auto Salvage" }
	};
	
	vars.tombValues = new Dictionary<int, string>()
	{
		{ 2466, "Capernaum" },
		{ 2571, "Canaveral" },
		{ 1595, "Fairwood" },
		{ 3040, "Hedgefield" },
		{ 2734, "Narrows Vale" },
		{ 2428, "Central" },
		{ 1945, "Westport" },
		{ 2157, "Crown" },
		{ 2215, "Vulcan" },
		{ 4209, "Everglade" },
		{ 3872, "Sunburn Desert" },
		{ 3846, "Solaris" },
		{ 3987, "Serpent's Crossing" },
		{ 1415, "Borealis" },
		{ 946, "Arcturus" },
		{ 1208, "Hibernus" },
		{ 1485, "Frore" },
		{ 996, "Polaris" },
		{ 1549, "Frost Horn Lower" },
		{ 680, "Frost Horn Upper" }
	};
	print("Initialized " + vars.tombValues.Count.ToString() + " tombs.");
	
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
	vars.campfireValues.Add(2957, "Bowel Lake Camping Grounds");
	
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