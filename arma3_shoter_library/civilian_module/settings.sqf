A3L_CM_directory             = "arma3_shoter_library\civilian_module\";
A3L_CM_language              = "pl";
A3L_CM_SpawnRadius           = [150 , 1500];
A3L_CM_DespawnRadius         = 2000;
A3L_CM_CivsFolders           = [ "BASE" ];
A3L_CM_SleepTime             = 1; // Higher = Less Cpu Load

//DEBUG
A3L_CM_debug                 = true;
//IF above is false, values below won't work
A3L_CM_debug_civSpawn        = false;
A3L_CM_debug_fear            = true;

A3L_CM_WanderChance          = 90;
A3L_CM_CivLimit              = 120;
A3L_CM_VehLimit              = 25;
A3L_CM_DriversLimit          = 5;
A3L_CM_CivInteraction        = true;
A3L_CM_PlayerInteraction     = true;
A3L_CM_EnemyInteraction      = true;
A3L_CM_OtherInteraction      = true; //Interactions defines by player
A3L_CM_FearlessCivilians     = false;
A3L_CM_CivSleep              = true;

A3L_CM_CuriosityFalloff      = 200.0; //per minute

//FEAR Settings
A3L_CM_PlayerFear = true;
A3L_CM_WestFear = true;
A3L_CM_EastFear = true;
A3L_CM_ResFear = true; //resistance fear
A3L_CM_CivFear = false; //It is mostly not needed unless civilians can use weapons.


//CIVILIAN CONFIG
A3L_CM_MaxCuriosity          = 200;
A3L_CM_MinCivilianMultiplier = 1;
A3L_CM_MaxCivilianMultiplier = 5;
A3L_CM_MinPlayerMultiplier   = 0;
A3L_CM_MaxPlayerMultiplier   = 10;
A3L_CM_MinEnemyMultiplier    = 0;
A3L_CM_MaxEnemyMultiplier    = 10;
A3L_CM_MinOtherMultiplier    = 1;
A3L_CM_MaxOtherMultiplier    = 10;
A3L_CM_MaxFear               = 1000;
A3L_CM_FearMultiplier        = 5;

//Curiosity
A3L_CM_CivBaseCuriosity = 5;

//EMPTY ARRAYS!
A3L_CM_CivClasses            = [];
A3L_CM_HouseClasses          = [];
A3L_CM_InterestPoints        = [];


A3L_CM_SleepInitTime         = 1; // DO NOT CHANGE TO SMALLER VALUES! (default = 5)
A3L_CM_BuildingCheckPeriod   = 30; //Time between checking again for buildings around players.

A3L_CM_d_CIVLOOP             = 0;
A3L_CM_LOOP                  = 0; //help value
A3L_CM_CLOOP                 = 0; //Special loop for civils