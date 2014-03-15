//if (isnil "A3L_CM_directory") exitwith {hint "SCM is already running"};


call compile preprocessFile "arma3_shoter_library\civilian_module\settings.sqf";
_languageFile = ("strings_" + A3L_CM_language + ".sqf");
call compile preprocessFile (A3L_CM_directory + _languageFile);

{
_tmp = A3L_CM_directory + _x +  "\init.sqf";
call compile preprocessFile _tmp;
} forEach A3L_CM_CivsFolders;

_tmp = A3L_CM_directory + "Szym_Gracze\Active_Players.sqf";
if (isNil "SZYM_fnc_gracze") then {SZYM_fnc_gracze = compile preprocessFile _tmp };

_tmp = A3L_CM_directory + "functions\find_buildings.sqf";
A3L_CM_FindBuildings  =  compile preprocessFile _tmp;

_tmp = A3L_CM_directory + "functions\create_civil.sqf";
A3L_CM_CreateCivil =  compile preprocessFile _tmp;

_tmp = A3L_CM_directory + "functions\find_towns.sqf";
A3L_CM_FindTowns =  compile preprocessFile _tmp;

_tmp = A3L_CM_directory + "functions\do_new.sqf";
A3L_CM_DoNew =  compile preprocessFile _tmp;

_tmp = A3L_CM_directory + "functions\calculate_curio.sqf";
A3L_CM_CalculateCurio =  compile preprocessFile _tmp;

_tmp = A3L_CM_directory + "functions\civil_goto.sqf";
A3L_CM_CivilGoto =  compile preprocessFile _tmp;

_tmp = A3L_CM_directory + "functions\create_heat.sqf";
A3L_CM_CreateHeat =  compile preprocessFile _tmp;

_tmp = A3L_CM_directory + "functions\process_heatsource.sqf";
A3L_CM_ProcessHeatSource =  compile preprocessFile _tmp;

_tmp = A3L_CM_directory + "functions\debug_heat.sqf";
A3L_CM_DebugHeat =  compile preprocessFile _tmp;

_tmp = A3L_CM_directory + "functions\add_heatsource.sqf";
A3L_CM_AddHeatSource =  compile preprocessFile _tmp;


if (A3L_CM_debug) then { hint "Starting SCM Debug"; };

//Variables

A3L_CM_Civilians         = [];
A3L_CM_Vehicles          = [];
A3L_CM_West              = [];
A3L_CM_East              = [];
A3L_CM_Towns             = nearestLocations [[0,0,0], ["NameVillage","NameCity","NameCityCapital"], 250000]; ;
A3L_CM_InterestPoints    = [];
A3L_CM_LastBuildingCheck = -A3L_CM_BuildingCheckPeriod;
A3L_CM_BuildingList      = [];
A3L_CM_HeatSources       = [];
A3L_CM_WHeat           = [];
A3L_CM_EHeat           = [];
A3L_CM_CHeat           = [];
A3L_CM_PHeat           = [];

[player, "P", "CONST", 10, 30, false] call A3L_CM_AddHeatSource;

_tmp = A3L_CM_directory + "functions\find_interests.sqf";
call compile preprocessFile _tmp;

sleep A3L_CM_SleepInitTime;

A3L_PlayerList = A3L_PlayerList + [p2];

if( A3L_CM_debug ) then
	{
		{
			A3L_CM_LOOP = A3L_CM_LOOP + 1;
			_markerstr = createMarker [format["TOWN%1", A3L_CM_LOOP], position _x];
			_markerstr setMarkerShape "ICON";
			_markerstr setMarkerType "mil_dot";
			_markerstr setmarkercolor "colorred";
			_markerstr setMarkerText format["TOWN - %1", A3L_CM_LOOP];
		} forEach A3L_CM_Towns;
	
	};
	
//FIND west/east units
{
   if ((side _x) == West) then
   {
		A3L_CM_West = A3L_CM_West + [_x];
		[_x, "W", "CONST", 10, 15, false] call A3L_CM_AddHeatSource;
   };
   if((side _x) == East ) then
   {
		A3L_CM_East = A3L_CM_East + [_x];
		[_x, "E", "CONST", 10, 15, false] call A3L_CM_AddHeatSource;
   };
} forEach allUnits;
	
while {true} do
{
_czas = time;
//RESETS
A3L_CM_WHeat           = [];
A3L_CM_EHeat           = [];
A3L_CM_PHeat           = [];
A3L_CM_CHeat           = [];

//Program loop
_curiosityFall = (A3L_CM_CuriosityFalloff * A3L_CM_SleepTime) / 60;
if( (count A3L_CM_Civilians) < A3L_CM_CivLimit) then
	{

		//respawn new civilians if there are spare buildings and they do not exceed max limit
		
		if(( time - A3L_CM_LastBuildingCheck) > A3L_CM_BuildingCheckPeriod) then
			{
				private["_czas"];
				_czas = time;
				A3L_CM_BuildingList = call A3L_CM_FindBuildings;
				A3L_CM_LastBuildingCheck = time;
				player sidechat format ["Building find - %1" , time - _czas ];	
			};
		
		//TODO - Do not call FindBuildings too often
		
		//hint format ["Budynki - %1", count A3L_BuildingList];
		if ((count A3L_CM_Civilians) < ( (count A3L_CM_BuildingList) * 2)) then
			{
				_budynek = A3L_CM_BuildingList select (floor random( count A3L_CM_BuildingList ) );
				_civil = [_budynek] call A3L_CM_CreateCivil;
				A3L_CM_Civilians = A3L_CM_Civilians + [_civil];
			};
	};	
if( (count A3L_CM_Vehicles) < A3L_CM_VehLimit) then
	{
	
	//create vehs here
	
	};
	
	//HEAT
	private["_czas"];
	_czas = time;
	call A3L_CM_ProcessHeatSource;
	player sidechat format ["heat - %1s" , time - _czas ];	
	if(A3L_CM_debug) then {
		if( isNil 'A3L_CM_d_HeatMarkersLoop' ) then
		{
			A3L_CM_d_HeatMarkersLoop = 0;
		} else {
			for [ {_i = 0} , {_i < A3L_CM_d_HeatMarkersLoop } , {_i = _i+1} ] do
			{
				deleteMarker format [ "HDM%1", _i ];
			};
			A3L_CM_d_HeatMarkersLoop = 0;
		};
		[A3L_CM_WHeat] call A3L_CM_DebugHeat;
		[A3L_CM_EHeat] call A3L_CM_DebugHeat;
		[A3L_CM_PHeat] call A3L_CM_DebugHeat;
		[A3L_CM_CHeat] call A3L_CM_DebugHeat;
		hint format [ "W - %1\nE - %2\nP - %3\nC - %4", count A3L_CM_WHeat, count A3L_CM_EHeat, count A3L_CM_PHeat, count A3L_CM_CHeat];
	};
	
		
	//Civilian loop
	{
	
		_civ                = _x;
		_civ_info           = _civ         getVariable "civ_info";
		
		_action             = _civ_info    select 1; 
		_actionName         = _action      select 0;
		_actionParams       = _action      select 1;
		
		_personality        = _civ_info    select 0;
		_curious            = _personality select 0;
		_playerMultiplayer  = _personality select 1;
		_civilianMultiplier = _personality select 2;
		_enemyMultiplier    = _personality select 3;
		_fear               = _personality select 4;
		_maxFear            = _personality select 5;
		
		_id                 = _civ         getVariable "id";
		
		format["CIV%1", _id] setMarkerPos position _civ; 
		
		//hint format[ "%1 - action %2" , _id, _actionName ];
		
		switch( _actionName ) do
			{
				case "WAIT" :
					{
						//Find him something interesting!
						//[_civ] call A3L_CM_DoNew;
					
					};
			
			};
		
		
	
	} forEach A3L_CM_Civilians;



player sidechat format ["ms - %1" , time - _czas ];
sleep A3L_CM_SleepTime;
};

