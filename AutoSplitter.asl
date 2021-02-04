
state("Technomage", "v1.02.NOCD")
{
	// Technomage.exe: 400000
	// Booleans true if 1
	// not in menu or options or TM-logo-animation
	int inGame   : "Technomage.exe", 0xB00660;
	// when inGame then this represents if the game is running or paused with esc, load/save etc
	int paused   : "Technomage.exe", 0x194D44;
	// Dreamertown inventory 1 if in inventory 0 if not (compass is 'in inventory' if you have it)
	int compass  : "Technomage.exe", 0x150184;
	int balloon  : "Technomage.exe", 0x1501FC;
	
	// Global Inventory
	int gold  : "Technomage.exe", 0x15019C;
	int strengthCube  : "Technomage.exe", 0x150100;
	
	//Steamertown inventory
	int oilCan  : "Technomage.exe", 0x1502B0;
	int cork  : "Technomage.exe", 0x15025C;
	int stew  : "Technomage.exe", 0x150280;
	int castorStew  : "Technomage.exe", 0x15028C;
	int cat  : "Technomage.exe", 0x150250;
	int castorOil  : "Technomage.exe", 0x150268;
	
	
	// Level like 1 - Dreamertown, 2 - Steamertown, 3 - Hive, ... stays set in Menu!
	int level    : "Technomage.exe", 0x15ABAC;
	
	// Map values
	/*
	1: Dreamertown
	2: House Vesneggs inkl. cellar
	3: House Sengarn
	4: House Encende
	5: Melvins House
	6: School
	7: Wine Shop
	8: Inn
	9: Library
	10: High Council
	11: Risens House inkl. cellar
	12: Dreamertown Night	
	13: Empty House
	
	// Steamertown
	1: 
	2: 
	3: 
	4: 
	5: 
	6: 
	7: 
	8: Steamertown
	9: 
	10:  
	11: 
	12: 	
	13: 
	14:
	15:
	16:Ol'Raake's House
	17: Engeneers House
	18: Hospital
	19:
	20: Smith
	21: Stm. House
	22: Miners shap
	23: Trader
	*/
	int map      : "Technomage.exe", 0x461748;
	
	int altMap  : "Technomage.exe", 0x461748; // alternative map value, seems to be the same
	
}

startup
{

	print("SturtUp start");
	Action<int, string, string, string> AddLevelSplit = (key, name, description, episode) => {
		settings.Add("inLevel"+key, true, name, episode);
		settings.SetToolTip("inLevel"+key, description);
	};


	settings.Add("level1", true, "Dreamertown");
	AddLevelSplit(1, "Balloon", "bla", "level1");
	AddLevelSplit(2, "Town Well", "bla", "level1");
	AddLevelSplit(3, "Rat", "bla", "level1");
	settings.Add("level2", true, "Steamertown");
	
	vars.prevUpdateTime = -1;
	print("SturtUp done");
}


init
{
	print("Init start/done");
	return;
}

exit
{
	print("Exit start/done");
	timer.IsGameTimePaused = true;
}

update
{
	// print("Update start");
	var timeSinceLastUpdate = Environment.TickCount - vars.prevUpdateTime;
	vars.prevUpdateTime = Environment.TickCount;
	// print("Update done");
	
}

start
{
	if (current.inGame == 1 && current.level == 1) {
		print("Start timer? YES!, ingame:" + current.inGame + " Level: " + current.level);
		return true;
	}
	print("Start timer? Nooo, ingame:" + current.inGame + " Level: " + current.level);
}

split
{
	if (current.inGame == 0 )
	{
		return;
	}
	print("Compass: " + current.compass + " balloon: " + current.balloon);
	print("Level: " + current.level);
	// Getting compass
	if (current.compass == 1 && old.compass == 0)
	{
		return true;
	}
	
	// Giving the balloon
	if (current.balloon == 0 && old.balloon == 1)
	{
		return true;
	}
	
	if (current.level == old.level+1)
	{
		return true;
	}
}

isLoading
{
	return current.inGame == 0;
}


