state("DYSMANTLE")
{
	int chunkId : "prog.dll", 0x005EA868, 0x00, 0x18C;
	int numTowers : "prog.dll", 0x005DAC10, 0x190, 0x58, 0x8C;
	
	//float gatekeeperHealth : "prog.dll", 0x005DAF20, 0x00, 0x10, 0x46C;
}

startup 
{
	vars.towerValues = new Dictionary<int, string>()
	{
		{ 2565, "captower" },
		{ 2576, "cantower" },
		{ 1991, "fairtower" },
		{ 3045, "hedgetower" },
		{ 2836, "narrowtower" },
		{ 2049, "centower" },
		{ 2129, "westtower" },
		{ 1964, "crowntower" },
		{ 2887, "vultower" },
		{ 3821, "evertower" },
		{ 3104, "suntower" },
		{ 3472, "soltower" },
		{ 4090, "serpenttower" },
		{ 1029, "bortower" },
		{ 1043, "arctower" },
		{ 1110, "hibtower" },
		{ 1002, "froretower" },
		{ 604, "poltower" },
		{ 393, "frosttower" }
	};
	
	settings.Add("towers", true, "Towers");
	settings.Add("bosses", true, "Bosses");
	//Other parent settings
	
	settings.CurrentDefaultParent = "towers";
	settings.Add("captower", true, "Capernaum");
	settings.Add("cantower", true, "Canaveral");
	settings.Add("fairtower", true, "Fairwood");
	settings.Add("hedgetower", true, "Hedgefield");
	settings.Add("narrowtower", false, "Narrows Vale");
	settings.Add("centower", true, "Central");
	settings.Add("westtower", true, "Westport");
	settings.Add("crowntower", true, "Crown");
	settings.Add("vultower", false, "Vulcan");
	settings.Add("evertower", true, "Everglade");
	settings.Add("suntower", true, "Sunburn Desert");
	settings.Add("soltower", true, "Solaris");
	settings.Add("serpenttower", true, "Serpent's Crossing");
	settings.Add("bortower", true, "Borealis");
	settings.Add("arctower", true, "Arcturus");
	settings.Add("hibtower", false, "Hibernus");
	settings.Add("froretower", true, "Frore");
	settings.Add("poltower", true, "Polaris");
	settings.Add("frosttower", true, "Frost Horn");
	
	//settings.CurrentDefaultParent = "bosses";
	//settings.Add("gatekeeper", true, "False Gatekeeper");
}

split
{
	//If the number of towers activated has increased and you are standing near the selected one
	if (current.numTowers > old.numTowers && vars.towerValues.ContainsKey(current.chunkId) && settings[vars.towerValues[current.chunkId]])
	{
		return true;
	}
	
	/*If the gatekeeper has been defeated
	if (settings["gatekeeper"] && current.gatekeeperHealth <= 0.05 && old.gatekeeperHealth > 0.05)
	{
		return true;
	}*/
	
	return false;
}
