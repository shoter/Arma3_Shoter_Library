private["_building"];
_group = createGroup Civilian;

_classname = A3L_CM_CivClasses select (floor random( count A3L_CM_CivClasses ) );
_civilian = _group createUnit [_classname, [0,0], [], 30, "FORM"];   
commandStop _civilian;

_building = _this select 0;

_civilian setPos [ (getPos _building select 0), (getPos _building select 1), 2 ];

A3L_CM_CLOOP = A3L_CM_CLOOP + 1;
_civilian setVariable [ "id", A3L_CM_CLOOP, false ];

if ( A3L_CM_debug ) then 
	{
		
		_markerstr = createMarker [format["CIV%1", A3L_CM_CLOOP], position _building];
		_markerstr setMarkerShape "ICON";
		_markerstr setMarkerType "mil_dot";
		_markerstr setmarkercolor "colorblue";
		_markerstr setMarkerText format["%1 W", A3L_CM_CLOOP];
		
		_civilian setVariable [ "debug_mark", _markerstr, false ];
		
	};

//Personality
// FIRST table 
//curiosity 
//Player-Curiosity-Multiplier 
//Civilian-Curiosity-Multiplier 
//Enemy-Curiosity-Multiplier 
//Fear 
//Max-Fear
//Fear-Multiplier

_civ_info = [];

_personality = [];
_personality = _personality + [0];
_personality = _personality + [ floor (A3L_CM_MinCivilianMultiplier + ( random (A3L_CM_MaxPlayerMultiplier - A3L_CM_MinCivilianMultiplier) )) ];
_personality = _personality + [ floor (A3L_CM_MinPlayerMultiplier   + ( random (A3L_CM_MaxPlayerMultiplier - A3L_CM_MinPlayerMultiplier)   )) ];
_personality = _personality + [ floor (A3L_CM_MinEnemyMultiplier    + ( random (A3L_CM_MaxEnemyMultiplier  - A3L_CM_MinEnemyMultiplier)    )) ];
_personality = _personality + [ floor (A3L_CM_MinOtherMultiplier    + ( random (A3L_CM_MaxOtherMultiplier  - A3L_CM_MinOtherMultiplier)    )) ];
_personality = _personality + [0, ( floor random A3L_CM_MaxFear ) ];
_personality = _personality + [( floor random A3L_CM_FearMultiplier )];

//Action
//1. What is he doing
//2. Additional parameters

_action = [ ["WAIT" , []] ];

_civ_info = _civ_info + [_personality] + _action + [position _building];

if ( A3L_CM_debug && A3L_CM_debug_civSpawn ) then 
	{
	hint format["pers - %1" , _civ_info];
	};

_civilian setVariable [ "civ_info", _civ_info, false ];
[_civilian, "C", "CONST", 3, 5, false] call A3L_CM_AddHeatSource;

_civilian;






