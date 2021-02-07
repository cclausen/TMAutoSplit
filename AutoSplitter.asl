/*
This file explains all ingame-memory-cheating I found

Savegame editing explained at the end of the file

*/


state("Technomage", "v1.02.NOCD")
{
	// Technomage.exe: 0x400000
	// int-Booleans (true if 1)
	// not in menu or options or TM-logo-animation
	int inGame   		: "Technomage.exe", 0xB00660;
	// when inGame then this represents if the game is running or paused with esc, load/save etc
	int paused   		: "Technomage.exe", 0x194D44;
	
	
	/*
	changing inventory with these adresses won't show a new Ittem, but it's there and working. 
	The Inventory-slot-info is missing
	*/
	// Global Inventory
	int gold  			: "Technomage.exe", 0x15019C;
	int strengthCube  	: "Technomage.exe", 0x150100;
	int chalk		  	: "Technomage.exe", 0x150190;
	int healthPotion  	: "Technomage.exe", 0x1500A0;
	int ankh  			: "Technomage.exe", 0x15FFEC;
	
	// Dreamertown inventory 1 if in inventory 0 if not (compass is 'in inventory' if you have it)
	int compass  		: "Technomage.exe", 0x150184;
	int balloon  		: "Technomage.exe", 0x1501FC;
	int copperKey  		: "Technomage.exe", 0x150130;
	int silverKey  		: "Technomage.exe", 0x15013C; // Rissen cellar and whine trader	
	int steelKey  		: "Technomage.exe", 0x150145;
	int books	  		: "Technomage.exe", 0x1501F0;
	int shadeFern	  	: "Technomage.exe", 0x150208;
	int rose		  	: "Technomage.exe", 0x1501E4;
	int sandwich	  	: "Technomage.exe", 0x150214;
	int wine		  	: "Technomage.exe", 0x150220;
	int sleepingDraught	: "Technomage.exe", 0x15022C;
	// Dreamertown progress booleans
	int talkedToShach	: "Technomage.exe", 0x407A5C;
	
	//Steamertown inventory
	int oilCan  		: "Technomage.exe", 0x1502B0;
	int cork  			: "Technomage.exe", 0x15025C;
	int stew            : "Technomage.exe", 0x150280;
	int castorStew      : "Technomage.exe", 0x15028C;
	int cat             : "Technomage.exe", 0x150250;
	int castorOil       : "Technomage.exe", 0x150268;
	int dynamite        : "Technomage.exe", 0x150298;
	int loreLever       : "Technomage.exe", 0x150238;
	int zantium         : "Technomage.exe", 0x150244;
	int zantiumKey      : "Technomage.exe", 0x150130;
	int controlWheel    : "Technomage.exe", 0x1502A4;
	int cryptBronceKey  : "Technomage.exe", 0x150130;
	int cryptCopperKey  : "Technomage.exe", 0x150130;
	int cryptSilverKey  : "Technomage.exe", 0x15013C;
	int cryptGoldenKey  : "Technomage.exe", 0x150148;
	
	
	// Level like 1 - Dreamertown, 2 - Steamertown, 3 - Hive, ... stays set in Menu!
	int level    		: "Technomage.exe", 0x15ABAC; // What level am I
	int altLevel 		: "Technomage.exe", 0x428218; // allternative Level value, changing teleports
	
	// Map values
	/*
	// 1 - Dreamertown
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
	
	// 2 - Steamertown
	1: Crypt 1	
	2: Crypt 2
	3: Crypt 3?
	4: Mine 1
	5: Mine 2	
	6: Mine 3
	7: Mine 4		
	8: Steamertown
	9: Graveyard
	10: Steamer Park
	11: Scrapyard
	12: Steamertown night
	13: Graveyard night		
	14: Steamer Park night (yes there are dialogs for this)
	15: Scrapyard night (wrong side of triggerzone)
	16: Ol'Raake's House
	17: Engeneers House
	18: Hospital
	19: Godon's House
	20: Smith
	21: Stm. House
	22: Miners shap
	23: Trader
	
	// 3 - Hive
	1: Hive 1	
	2: Hive 2
	3: Hive 3
	4: Hive 4
	5: Hive 5	
	6: Hive 6
	7: Hive 7		
	8: Hive 8
	9: Hive 9
	10: Hive 10 (Endboss Spider)
	*/
	int map      		: "Technomage.exe", 0x461748; // Where am I
	
	int altMap  		: "Technomage.exe", 0x45D700; // alternative map value, changing teleports
	int altMap2  		: "Technomage.exe", 0x15ABB0; // alternative map value, changing a little later then others
	
}

startup
{
	
	// Should be sufficient
	refreshRate = 30;
	
	Action<int, string, string, string, bool> AddLevelSplit = (key, name, description, episode, check) => {
		settings.Add(episode+"_"+key, check, name, episode);
		settings.SetToolTip(episode+"_"+key, description);
	};

	settings.Add("levelSplits", true, "Split on level transitions");

	settings.Add("level1", true, "Dreamertown");
	AddLevelSplit(1, "Balloon", "Giving away the balloon", "level1", true);
	AddLevelSplit(2, "Rissen", "Entering Rissens house", "level1", true);
	AddLevelSplit(3, "Compass", "Geting the compass", "level1", true);
	AddLevelSplit(4, "Night", "Entering Dreamertown at night (after rat)", "level1", false);
	AddLevelSplit(5, "Sleeping Draught", "Getting the sleeping Draught", "level1", false);
	
	settings.Add("level2", true, "Steamertown");
	AddLevelSplit(1, "Enter Mine", "Entering the mine", "level2", true);
	AddLevelSplit(2, "Leave Mine", "Leaving the mine", "level2", true);
	AddLevelSplit(3, "Enter Crypt", "Entering the  crypt", "level2", true);
	AddLevelSplit(4, "Leave Crypt", "Leaving the  crypt (into Steamertown day)", "level2", true);
	AddLevelSplit(5, "Enter Steamerpark", "Entering Steamerpark", "level2", true);
	AddLevelSplit(6, "Getting zantium", "Getting zantium", "level2", false);
	AddLevelSplit(7, "Getting Control Wheel", "From Boss", "level2", false);
	AddLevelSplit(8, "Getting Lore Lever", "Getting Lore Lever", "level2", false);
	AddLevelSplit(9, "Getting golden Key in Crypt", "Getting golden Key in Crypt", "level2", false);
	
	settings.Add("level3", true, "Hive");
	
	vars.prevUpdateTime = -1;
	print("TechnoMage Autosplitter by Horroreyes successfully started");
}


init
{
	if (true) {// modules.First().ModuleMemorySize == 0x123456)
        version = "v1.02.NOCD";
	}
    else {
		print("best guess: the same as my adresses");
        version = "v1.02.NOCD";
	}
	vars.lastInGame = 0;
	return;
}

exit
{
	print("Exit start/done");
	timer.IsGameTimePaused = true;
}

update
{
	var timeSinceLastUpdate = Environment.TickCount - vars.prevUpdateTime;
	vars.prevUpdateTime = Environment.TickCount;
	
	/* if(current.inGame == 1){
		vars.lastInGame = Environment.TickCount;
	} else {
		vars.lastInGame = old.lastInGame;
	} */
	
}

start
{
	print("Start timer? ingame:" + old.inGame + "->" + current.inGame + " Level: " + current.level + " Compass: " + current.compass);
	// Start is new Game (-> from menu, now ingame, in first level map melvins house, should not start in loads for Steamertown)
	if (old.inGame == 0 && current.inGame == 1 && current.level == 1 && current.map == 5) {
		print("YES! New Game");
		return true;
	}
	
	// Start on lebel progression (if level splits are activated)
	if (settings["levelSplits"] &&  current.level == old.level+1)
	{
		print("YES! Next Level");
		return true;
	}
	print("Nooo!");
}

split
{
	if (current.inGame == 0 )
	{
		return;
	}
	// next Level Split
	if (settings["levelSplits"] &&  current.level == old.level+1)
	{
		return true;
	}
	
	// Dreamertown splits
	if(settings["level1"] && current.level == 1){
		
		// Giving the balloon
		if (settings["level1_1"] && old.balloon == 1 && current.balloon == 0)
		{
			return true;
		}
		
		// Entering Rissen
		if (settings["level1_2"] && old.map == 1 && current.map == 11)
		{
			return true;
		}
		
		// Getting compass
		if (settings["level1_3"] && old.compass == 0 && current.compass == 1)
		{
			return true;
		}
		
		// Leaving Rissen (night)
		if (settings["level1_4"] && old.map == 11 && current.map == 12)
		{
			return true;
		}
		
		// Getting compass
		if (settings["level1_5"] && old.sleepingDraught == 0 && current.sleepingDraught == 1 )
		{
			return true;
		}
	}
	
	// Steamertown splits
	if(settings["level2"] && current.level == 2){
		
		// Enter Mine
		if (settings["level2_1"] && old.map == 8 && current.map == 4)
		{
			return true;
		}
		
		// Leave Mine
		if (settings["level2_2"] && old.map == 4 && current.map == 8)
		{
			return true;
		}
		
		// Enter Crypt
		if (settings["level2_3"] && old.map == 13 && current.map == 1)
		{
			return true;
		}
		
		// Leave Crypt
		if (settings["level2_4"] && old.map == 1 && current.map == 9)
		{
			return true;
		}
		
		// Enter Steamer Park
		if (settings["level2_5"] && old.map == 8 && current.map == 10)
		{
			return true;
		}
		
		// Getting zantium
		if (settings["level2_6"] && old.zantium == 0 && current.zantium == 1)
		{
			return true;
		}
		
		// Getting Control Wheel
		if (settings["level2_7"] && old.controlWheel == 0 && current.controlWheel == 1)
		{
			return true;
		}
		
		// Getting Lore Lever
		if (settings["level2_8"] && old.loreLever == 0 && current.loreLever == 1)
		{
			return true;
		}
		
		// Getting golden Key
		if (settings["level2_9"] && old.cryptGoldenKey == 0 && current.cryptGoldenKey == 1)
		{
			return true;
		}
	}
	
	// Hive splits
	if(settings["level3"] && current.level == 3){
		
		
	}
	
}

isLoading
{
	return current.inGame == 0 || current.paused == 1;
}

reset
{
	/*if(current.inGame == 0 && (current.lastInGame - Environment.TickCount) > 500){
		return true;
	}*/
}


/*

Savegame editing (from http://www.cheatbook.de/files/techmage.htm

In a saved game in the directory SAVES under the installed directory 
(filenames "TMN_01.TSG" through "TMN_10.TSG"), are the following addresses: 

To enable all skill items (bow, fireball, earthquake, etc.), the following 
addresses should be set to 01 hex unless a non-zero value is already there: 

4b18,4b1c
4b20,4b24,4b28,4b2c
4b30,4b34,4b38,4b3c
4b40,4b44,4b48,4b4c
4b50,4b54,4b58,4b5c
4b60,4b64,4b68,4b6c
4b70,4b74,4b78,4b7c 

4f14-4f49 - 27 Inventory slots, 2 bytes per slot.
If the slot is empty, the values are ff ff hex
If the slot is occupied, the first byte is the item code (below), 
the second byte is 00 hex. 

Inventory Item Codes (in hex) 

value - description (hex address of the number of the item the player has)
-=Common=-
1b - arrows (4b80 - set to ff hex for infinite arrows)
1c - fire arrows (4b84 - set to ff hex for infinite fire arrows) 
1d - water arrows (4b88 - set to ff hex for infinite water arrows)
1e - small healing potion (4b8c) 
1f - large healing potion (4b90) 
20 - small combined potion (4b94) 
21 - large combined potion (4b98) 
22 - small mana potion (4b9c) 
23 - large mana potion (4ba0) 
24 - anti-venom herb (4ba4) 
25 - anti-venom potion (4ba8) 
26 - magic cube (strength) (4bac) 
27 - magic cube (intelligence) (4bb0) 
28 - magic cube (constitution) (4bb4) 
29 - magic cube (mystic) (4bb8) 
2a - copper key (4bbc) 
2b - silver key (4bc0) 
2c - gold key (4bc4) 
2d - steel key (4bc8) 
2f - torch (4bd0) 
31 - compass (N/A) 
32 - chalk (4bdc)
Dreamertown:
39 - a rose (4bf8)
3a - Mrs. Sengarn's books (4bfc)
3b - a balloon, somewhat deflated (4c00)
3c - shade fern (4c04)
3d - bread and butter (4c08)
3e - Master Bacchus' best booze (4c0c)
3f - sleeping draught (4c10)
Steamertown:
40 - crowbar (4c14)
41 - lump of zantium (4c18)
42 - kitten (4c1c)
43 - cork (4c20)
44 - castor oil (4c24)
45 - empty stew plate (4c28)
46 - stew (4c2c)
47 - stew with castor oil (4c30)
48 - dynamite (4c34)
49 - control wheel (4c38)
4a - oil can (4c3c)
The Hive:
4b - black module (4c40)
4c - blue module (4c44)
4d - green module (4c48)
4e - red module (4c4c)
Fairy Forest:
4f - silverweed (4c50)
50 - blue ice flower (4c54)
51 - red sunflower (4c58)
52 - dark green flower (4c5c)
53 - light green spring flower (4c60)
54 - honeycomb (4c64 - adds this value with value in other honeycomb) 
55 - branch from an old oak (4c68) 
56 - Horpach's magic wand (4c6c) 
57 - good luck potion (4c70) 
58 - yellow crystal (4c74) 
59 - honeycomb (4c78) 
5a - empty bucket (4c7c) 
5b - bucket of fresh water (4c80) 
5c - captured bee (4c84) 
5d - fish seal (4c88) 
5e - horse seal (4c8c) 
5f - bird seal (4c90) 
60 - shrinking potion (4c94) 
61 - harp strings (4c98) 
62 - knife (4c9c) 
63 - silk thread (4ca0)
64 - bee sting (4ca4) 
65 - fairy gold (4ca8) 
66 - bee basket (4cac) 
67 - wooden mask (pass) (4cb0) 
68 - ray glass (4cb4) 
69 - moonbeams in a ray glass (4cb8) 
6a - antidote potion (4cbc) 
6b - antidote potion blessed by a royal smile (4cc0) 
6c - tuning fork (4cc4) 
6d - honey glass (for catching bees) (4cc8) 
6e - gear wheel (4ccc)
Canyon:
6f - red eye stone (4cd0)
70 - green eye stone (4cd4)
71 - blue eye stone (4cd8)
72 - yellow eye stone (4cdc)
74 - red lens (4ce4)
75 - green lens (4ce8)
76 - blue lens (4cec)
77 - Cahoch-Ran's horn (4cf0)
78 - lever (4cf4)
79 - old spectacles (4cf8)
Tower:
7a - black pearl (4d00)
7b - belladonna (4d04)
7c - empty urn (4d08)
7d - urn filled with ashes (4d0c)
7e - book on ghost conjuring (4d10)
Volcano:
80 - blue iron ball (4d14)
81 - bucket (4d18)
82 - lump of metal (4d1c)
83 - Ruisorne's voting coin (4d20)
84 - gambler's voting coin (4d24)
85 - Cistorne's voting coin (4d28)
86 - the evidence (4d2c)
87 - shovel (4d30)
88 - crystal (4d34)
89 - stardust (4d38)
8a - geode (4d3c)
8b - book (4d40)
8c - amulet (4d44)
8d - crystal (4d48)
8e - dragon's tooth (4d4c)
8f - egg from the hive (4d50)
90 - goblet of mead (4d54)
91 - nut (4d58)
92 - mushroom (4d5c)
93 - ring (4d60)
94 - skull (4d64)
95 - shard of mana crystal (4d68)
Ruins:
96 - fish (4d6c)
97 - berries (4d70)
98 - black keystone (4d74)
99 - white keystone (4d78)
9a - red keystone (4d7c)
9b - blue keystone (4d80)
9c - green keystone (4d84)
9d - yellow keystone (4d88)
9e - energy pearl (4d8c)
9f - seal of mysticism (4d90)
a0 - seal of combat (4d94)
a1 - seal of defence (4d98)
a2 - seal of magic (4d9c) 

Note 1: Many of these items will only display properly in the inventory list 
        depending on what level is being played. 

Note 2: Adding the above values to the inventory area is only the first step. To 
        have the game acknowledge that the item displayed in the inventory is 
        actually there, the hex address in parenthesis has to have a non-zero value.

4be0-2 - Gold; Max 3f 42 0f hex ($999,999)
4f51-2 and 4f59-a - Location player is standing. 
Playing with these values can actually relocate the player to a 
desired location. Subtracting from 4f51-2 moves the player to the 
west in the game. Adding to 4f51-2 moves the player to the east. 
Subtracting from 4f59-a moves the player north and adding moves 
the player south. Try adding (or subtracting) one or two hex values 
to (or from) the leftmost bit of address 4f51 (or 4f59). 
So a hex a5 would become hex b5 if adding and hex 95 if 
subtracting. If that value is already very near the maximum 
of ff, then make the leftmost bit a 0 and add 1 to the righmost 
bit of address 4f52 (or 4f5a). 
So hex f5 01 would become hex 05 02. Quite often you will end up 
on top of a wall separating one room from another. Simply walk to 
where you wanted to be and drop down. Note: 
The corresponding *memory* locations are 827b0d-e for east-west 
and 827b15-6 for north-south. 
 
A program like Magic Trainer Creator can be used to manipulate 
these locations. This is especially useful in the final battle 
when saving the game is not permitted. 

73ad - Strength skill(STR); Max 28 hex
73ae - Intelligence skill(INT); Max 28 hex
73af - Constitution skill(CON); Max 28 hex
73b0 - Mystical skill(MYS); Max 28 hex
